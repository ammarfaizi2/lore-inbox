Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVAaBQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVAaBQW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 20:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVAaBQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 20:16:22 -0500
Received: from bay19-dav18.bay19.hotmail.com ([64.4.53.198]:60666 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261885AbVAaBMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 20:12:05 -0500
Message-ID: <BAY19-DAV18867B4530F85B0CF0E9AEC57C0@phx.gbl>
X-Originating-IP: [219.65.238.51]
X-Originating-Email: [nitin_gupta_mail@hotmail.com]
Reply-To: "Nitin" <nitin_gupta_mail@hotmail.com>
From: "Nitin" <nitin_gupta_mail@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Patch for CIFS vfs client
Date: Mon, 31 Jan 2005 06:46:17 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C50760.90604410"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcUHMnaUCqHOGdW4STC9lda/ywsO4Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 31 Jan 2005 01:12:00.0808 (UTC) FILETIME=[DDEDFA80:01C50731]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C50760.90604410
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This is the patch for CIFS ver 1.22 (included with linux-2.6.8)
This improves cifs vfs client file read performance by 10-15%.

Changes were made only to a single file in cifs tree=20
(/usr/src/linux/fs/cifs/file.c)

The function cifs_readpages() is modifed and cifs_readpages_threadfn() =
has
been added.
=A0
It implements sending back-to-back multiple read requests using single
connection stream.

To use it, replace existing file.c file with this file (as attachment)

Still to do --=20
-- submit multiple read requests in parallel using _multiple =
connections_
-- dynamically control no. of threads operating depending on server =
response
time

I have tested it to be quite stable.

Please give test results and comments to --

nitin_gupta_mail@hotmail.com
Nitin Gupta


Thanks


------=_NextPart_000_0000_01C50760.90604410
Content-Type: text/plain;
	name="file.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="file.c"

/*	 <modified file.c>=0A=
 *	 modified function cifs_readpages()=0A=
 *	 added function cifs_readpages_threadfn()=0A=
 *	 =0A=
 *=0A=
 *   fs/cifs/file.c=0A=
 *=0A=
 *   vfs operations that deal with files=0A=
 * =0A=
 *   Copyright (C) International Business Machines  Corp., 2002,2003=0A=
 *   Author(s): Steve French (sfrench@us.ibm.com)=0A=
 *=0A=
 *   This library is free software; you can redistribute it and/or modify=0A=
 *   it under the terms of the GNU Lesser General Public License as =
published=0A=
 *   by the Free Software Foundation; either version 2.1 of the License, =
or=0A=
 *   (at your option) any later version.=0A=
 *=0A=
 *   This library is distributed in the hope that it will be useful,=0A=
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See=0A=
 *   the GNU Lesser General Public License for more details.=0A=
 *=0A=
 *   You should have received a copy of the GNU Lesser General Public =
License=0A=
 *   along with this library; if not, write to the Free Software=0A=
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA=0A=
 */=0A=
#include <linux/fs.h>=0A=
#include <linux/stat.h>=0A=
#include <linux/fcntl.h>=0A=
#include <linux/pagemap.h>=0A=
#include <linux/pagevec.h>=0A=
#include <linux/smp_lock.h>=0A=
#include <asm/div64.h>=0A=
#include "cifsfs.h"=0A=
#include "cifspdu.h"=0A=
#include "cifsglob.h"=0A=
#include "cifsproto.h"=0A=
#include "cifs_unicode.h"=0A=
#include "cifs_debug.h"=0A=
#include "cifs_fs_sb.h"=0A=
=0A=
#include <asm/atomic.h>=0A=
#include <asm/spinlock.h>=0A=
#include <linux/kthread.h>=0A=
=0A=
#define FIN_WAIT 1=0A=
#define FIN_ERR  3=0A=
=0A=
struct per_thread_data {=0A=
	int interrupted;=0A=
	wait_queue_head_t wq_h;=0A=
	=0A=
	int xid, rsize_in_pages;=0A=
	struct file *file;=0A=
	struct address_space *mapping;=0A=
	struct list_head *page_list;=0A=
	struct pagevec lru_pvec;=0A=
	struct cifsFileInfo * open_file;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	=0A=
	spinlock_t sl_page_pool;=0A=
	spinlock_t sl_cache_lock;=0A=
	struct semaphore threadsem;=0A=
	volatile struct list_head *page_pool;=0A=
	=0A=
	atomic_t pages_left;=0A=
	atomic_t read_state;=0A=
	atomic_t thread_count;=0A=
	atomic_t threads_required;=0A=
};=0A=
=0A=
=0A=
int=0A=
cifs_open(struct inode *inode, struct file *file)=0A=
{=0A=
	int rc =3D -EACCES;=0A=
	int xid, oplock;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	struct cifsFileInfo *pCifsFile;=0A=
	struct cifsInodeInfo *pCifsInode;=0A=
	struct list_head * tmp;=0A=
	char *full_path =3D NULL;=0A=
	int desiredAccess =3D 0x20197;=0A=
	int disposition;=0A=
	__u16 netfid;=0A=
	FILE_ALL_INFO * buf =3D NULL;=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	cifs_sb =3D CIFS_SB(inode->i_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
=0A=
	if (file->f_flags & O_CREAT) {=0A=
		/* search inode for this file and fill in file->private_data =3D */=0A=
		pCifsInode =3D CIFS_I(file->f_dentry->d_inode);=0A=
		read_lock(&GlobalSMBSeslock);=0A=
		list_for_each(tmp, &pCifsInode->openFileList) {            =0A=
			pCifsFile =3D list_entry(tmp,struct cifsFileInfo, flist);           =0A=
			if((pCifsFile->pfile =3D=3D NULL)&& (pCifsFile->pid =3D =
current->pid)){=0A=
			/* mode set in cifs_create */=0A=
				pCifsFile->pfile =3D file; /* needed for writepage */=0A=
				file->private_data =3D pCifsFile;=0A=
				break;=0A=
			}=0A=
		}=0A=
		read_unlock(&GlobalSMBSeslock);=0A=
		if(file->private_data !=3D NULL) {=0A=
			rc =3D 0;=0A=
			FreeXid(xid);=0A=
			return rc;=0A=
		} else {=0A=
			if(file->f_flags & O_EXCL)=0A=
				cERROR(1,("could not find file instance for new file %p ",file));=0A=
		}=0A=
	}=0A=
=0A=
	down(&inode->i_sb->s_vfs_rename_sem);=0A=
	full_path =3D build_path_from_dentry(file->f_dentry);=0A=
	up(&inode->i_sb->s_vfs_rename_sem);=0A=
	if(full_path =3D=3D NULL) {=0A=
		FreeXid(xid);=0A=
		return -ENOMEM;=0A=
	}=0A=
=0A=
	cFYI(1, (" inode =3D 0x%p file flags are 0x%x for %s", inode, =
file->f_flags,full_path));=0A=
	if ((file->f_flags & O_ACCMODE) =3D=3D O_RDONLY)=0A=
		desiredAccess =3D GENERIC_READ;=0A=
	else if ((file->f_flags & O_ACCMODE) =3D=3D O_WRONLY)=0A=
		desiredAccess =3D GENERIC_WRITE;=0A=
	else if ((file->f_flags & O_ACCMODE) =3D=3D O_RDWR) {=0A=
		/* GENERIC_ALL is too much permission to request */=0A=
		/* can cause unnecessary access denied on create */=0A=
		/* desiredAccess =3D GENERIC_ALL; */=0A=
		desiredAccess =3D GENERIC_READ | GENERIC_WRITE;=0A=
	}=0A=
=0A=
/*********************************************************************=0A=
 *  open flag mapping table:=0A=
 *  =0A=
 *	POSIX Flag            CIFS Disposition=0A=
 *	----------            ---------------- =0A=
 *	O_CREAT               FILE_OPEN_IF=0A=
 *	O_CREAT | O_EXCL      FILE_CREATE=0A=
 *	O_CREAT | O_TRUNC     FILE_OVERWRITE_IF=0A=
 *	O_TRUNC               FILE_OVERWRITE=0A=
 *	none of the above     FILE_OPEN=0A=
 *=0A=
 *	Note that there is not a direct match between disposition=0A=
 *	FILE_SUPERSEDE (ie create whether or not file exists although =0A=
 *	O_CREAT | O_TRUNC is similar but truncates the existing=0A=
 *	file rather than creating a new file as FILE_SUPERSEDE does=0A=
 *	(which uses the attributes / metadata passed in on open call)=0A=
 *?=0A=
 *?  O_SYNC is a reasonable match to CIFS writethrough flag  =0A=
 *?  and the read write flags match reasonably.  O_LARGEFILE=0A=
 *?  is irrelevant because largefile support is always used=0A=
 *?  by this client. Flags O_APPEND, O_DIRECT, O_DIRECTORY,=0A=
 *	 O_FASYNC, O_NOFOLLOW, O_NONBLOCK need further investigation=0A=
 *********************************************************************/=0A=
=0A=
	if((file->f_flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
		disposition =3D FILE_CREATE;=0A=
	else if((file->f_flags & (O_CREAT | O_TRUNC)) =3D=3D (O_CREAT | =
O_TRUNC))=0A=
		disposition =3D FILE_OVERWRITE_IF;=0A=
	else if((file->f_flags & O_CREAT) =3D=3D O_CREAT)=0A=
		disposition =3D FILE_OPEN_IF;=0A=
	else=0A=
		disposition =3D FILE_OPEN;=0A=
=0A=
	if (oplockEnabled)=0A=
		oplock =3D REQ_OPLOCK;=0A=
	else=0A=
		oplock =3D FALSE;=0A=
=0A=
	/* BB pass O_SYNC flag through on file attributes .. BB */=0A=
=0A=
	/* Also refresh inode by passing in file_info buf returned by SMBOpen =0A=
	   and calling get_inode_info with returned buf (at least =0A=
	   helps non-Unix server case */=0A=
=0A=
	/* BB we can not do this if this is the second open of a file =0A=
	and the first handle has writebehind data, we might be =0A=
	able to simply do a filemap_fdatawrite/filemap_fdatawait first */=0A=
	buf =3D kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);=0A=
	if(buf=3D=3D0) {=0A=
		if (full_path)=0A=
			kfree(full_path);=0A=
		FreeXid(xid);=0A=
		return -ENOMEM;=0A=
	}=0A=
	rc =3D CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,=0A=
			CREATE_NOT_DIR, &netfid, &oplock, buf, cifs_sb->local_nls);=0A=
	if (rc) {=0A=
		cFYI(1, ("cifs_open returned 0x%x ", rc));=0A=
		cFYI(1, ("oplock: %d ", oplock));	=0A=
	} else {=0A=
		file->private_data =3D=0A=
			kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);=0A=
		if (file->private_data) {=0A=
			memset(file->private_data, 0, sizeof(struct cifsFileInfo));=0A=
			pCifsFile =3D (struct cifsFileInfo *) file->private_data;=0A=
			pCifsFile->netfid =3D netfid;=0A=
			pCifsFile->pid =3D current->pid;=0A=
			init_MUTEX(&pCifsFile->fh_sem);=0A=
			pCifsFile->pfile =3D file; /* needed for writepage */=0A=
			pCifsFile->pInode =3D inode;=0A=
			pCifsFile->invalidHandle =3D FALSE;=0A=
			pCifsFile->closePend     =3D FALSE;=0A=
			write_lock(&file->f_owner.lock);=0A=
			write_lock(&GlobalSMBSeslock);=0A=
			list_add(&pCifsFile->tlist,&pTcon->openFileList);=0A=
			pCifsInode =3D CIFS_I(file->f_dentry->d_inode);=0A=
			if(pCifsInode) {=0A=
				/* want handles we can use to read with first */=0A=
				/* in the list so we do not have to walk the */=0A=
				/* list to search for one in prepare_write */=0A=
				if ((file->f_flags & O_ACCMODE) =3D=3D O_WRONLY) {=0A=
					list_add_tail(&pCifsFile->flist,&pCifsInode->openFileList);=0A=
				} else {=0A=
					list_add(&pCifsFile->flist,&pCifsInode->openFileList);=0A=
				}=0A=
				write_unlock(&GlobalSMBSeslock);=0A=
				write_unlock(&file->f_owner.lock);=0A=
				if(pCifsInode->clientCanCacheRead) {=0A=
					/* we have the inode open somewhere else=0A=
					   no need to discard cache data */=0A=
				} else {=0A=
					if(buf) {=0A=
					/* BB need same check in cifs_create too? */=0A=
=0A=
					/* if not oplocked, invalidate inode pages if mtime =0A=
					   or file size changed */=0A=
						struct timespec temp;=0A=
						temp =3D cifs_NTtimeToUnix(le64_to_cpu(buf->LastWriteTime));=0A=
						if(timespec_equal(&file->f_dentry->d_inode->i_mtime,&temp) && =0A=
							(file->f_dentry->d_inode->i_size =3D=3D =
(loff_t)le64_to_cpu(buf->EndOfFile))) {=0A=
							cFYI(1,("inode unchanged on server"));=0A=
						} else {=0A=
							if(file->f_dentry->d_inode->i_mapping) {=0A=
							/* BB no need to lock inode until after invalidate*/=0A=
							/* since namei code should already have it locked?*/=0A=
								filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);=0A=
								filemap_fdatawait(file->f_dentry->d_inode->i_mapping);=0A=
							}=0A=
							cFYI(1,("invalidating remote inode since open detected it =
changed"));=0A=
							invalidate_remote_inode(file->f_dentry->d_inode);=0A=
						}=0A=
					}=0A=
				}=0A=
				if (pTcon->ses->capabilities & CAP_UNIX)=0A=
					rc =3D cifs_get_inode_info_unix(&file->f_dentry->d_inode,=0A=
						full_path, inode->i_sb,xid);=0A=
				else=0A=
					rc =3D cifs_get_inode_info(&file->f_dentry->d_inode,=0A=
						full_path, buf, inode->i_sb,xid);=0A=
=0A=
				if((oplock & 0xF) =3D=3D OPLOCK_EXCLUSIVE) {=0A=
					pCifsInode->clientCanCacheAll =3D TRUE;=0A=
					pCifsInode->clientCanCacheRead =3D TRUE;=0A=
					cFYI(1,("Exclusive Oplock granted on inode =
%p",file->f_dentry->d_inode));=0A=
				} else if((oplock & 0xF) =3D=3D OPLOCK_READ)=0A=
					pCifsInode->clientCanCacheRead =3D TRUE;=0A=
			} else {=0A=
				write_unlock(&GlobalSMBSeslock);=0A=
				write_unlock(&file->f_owner.lock);=0A=
			}=0A=
			if(oplock & CIFS_CREATE_ACTION) {           =0A=
				/* time to set mode which we can not set earlier due=0A=
				 to problems creating new read-only files */=0A=
				if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)                =0A=
					CIFSSMBUnixSetPerms(xid, pTcon, full_path, inode->i_mode,=0A=
						(__u64)-1, =0A=
						(__u64)-1,=0A=
						0 /* dev */,=0A=
						cifs_sb->local_nls);=0A=
				else {/* BB implement via Windows security descriptors */=0A=
			/* eg CIFSSMBWinSetPerms(xid,pTcon,full_path,mode,-1,-1,local_nls);*/=0A=
			/* in the meantime could set r/o dos attribute when perms are eg:=0A=
					mode & 0222 =3D=3D 0 */=0A=
				}=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
	if (buf)=0A=
		kfree(buf);=0A=
	if (full_path)=0A=
		kfree(full_path);=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
/* Try to reaquire byte range locks that were released when session */=0A=
/* to server was lost */=0A=
static int cifs_relock_file(struct cifsFileInfo * cifsFile)=0A=
{=0A=
	int rc =3D 0;=0A=
=0A=
/* BB list all locks open on this file and relock */=0A=
=0A=
	return rc;=0A=
}=0A=
=0A=
static int cifs_reopen_file(struct inode *inode, struct file *file, int =
can_flush)=0A=
{=0A=
	int rc =3D -EACCES;=0A=
	int xid, oplock;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	struct cifsFileInfo *pCifsFile;=0A=
	struct cifsInodeInfo *pCifsInode;=0A=
	char *full_path =3D NULL;=0A=
	int desiredAccess =3D 0x20197;=0A=
	int disposition =3D FILE_OPEN;=0A=
	__u16 netfid;=0A=
=0A=
	if(inode =3D=3D NULL)=0A=
		return -EBADF;=0A=
	if (file->private_data) {=0A=
		pCifsFile =3D (struct cifsFileInfo *) file->private_data;=0A=
	} else=0A=
		return -EBADF;=0A=
=0A=
	xid =3D GetXid();=0A=
	down(&pCifsFile->fh_sem);=0A=
	if(pCifsFile->invalidHandle =3D=3D FALSE) {=0A=
		up(&pCifsFile->fh_sem);=0A=
		FreeXid(xid);=0A=
		return 0;=0A=
	}=0A=
=0A=
	if(file->f_dentry =3D=3D NULL) {=0A=
		up(&pCifsFile->fh_sem);=0A=
		cFYI(1,("failed file reopen, no valid name if dentry freed"));=0A=
		FreeXid(xid);=0A=
		return -EBADF;=0A=
	}=0A=
	cifs_sb =3D CIFS_SB(inode->i_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
/* can not grab rename sem here because various ops, including=0A=
those that already have the rename sem can end up causing writepage=0A=
to get called and if the server was down that means we end up here,=0A=
and we can never tell if the caller already has the rename_sem */=0A=
	full_path =3D build_path_from_dentry(file->f_dentry);=0A=
	if(full_path =3D=3D NULL) {=0A=
		up(&pCifsFile->fh_sem);=0A=
		FreeXid(xid);=0A=
		return -ENOMEM;=0A=
	}=0A=
=0A=
	cFYI(1, (" inode =3D 0x%p file flags are 0x%x for %s", inode, =
file->f_flags,full_path));=0A=
	if ((file->f_flags & O_ACCMODE) =3D=3D O_RDONLY)=0A=
		desiredAccess =3D GENERIC_READ;=0A=
	else if ((file->f_flags & O_ACCMODE) =3D=3D O_WRONLY)=0A=
		desiredAccess =3D GENERIC_WRITE;=0A=
	else if ((file->f_flags & O_ACCMODE) =3D=3D O_RDWR) {=0A=
		/* GENERIC_ALL is too much permission to request */=0A=
		/* can cause unnecessary access denied on create */=0A=
		/* desiredAccess =3D GENERIC_ALL; */=0A=
		desiredAccess =3D GENERIC_READ | GENERIC_WRITE;=0A=
	}=0A=
=0A=
	if (oplockEnabled)=0A=
		oplock =3D REQ_OPLOCK;=0A=
	else=0A=
		oplock =3D FALSE;=0A=
=0A=
	=0A=
	/* Can not refresh inode by passing in file_info buf to be returned=0A=
	 by SMBOpen and then calling get_inode_info with returned buf =0A=
	 since file might have write behind data that needs to be flushed =0A=
	 and server version of file size can be stale. If we =0A=
	 knew for sure that inode was not dirty locally we could do this */=0A=
=0A=
/*	buf =3D kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);=0A=
	if(buf=3D=3D0) {=0A=
		up(&pCifsFile->fh_sem);=0A=
		if (full_path)=0A=
			kfree(full_path);=0A=
		FreeXid(xid);=0A=
		return -ENOMEM;=0A=
	}*/=0A=
	rc =3D CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,=0A=
				CREATE_NOT_DIR, &netfid, &oplock, NULL, cifs_sb->local_nls);=0A=
	if (rc) {=0A=
		up(&pCifsFile->fh_sem);=0A=
		cFYI(1, ("cifs_open returned 0x%x ", rc));=0A=
		cFYI(1, ("oplock: %d ", oplock));=0A=
	} else {=0A=
		pCifsFile->netfid =3D netfid;=0A=
		pCifsFile->invalidHandle =3D FALSE;=0A=
		up(&pCifsFile->fh_sem);=0A=
		pCifsInode =3D CIFS_I(inode);=0A=
		if(pCifsInode) {=0A=
			if(can_flush) {=0A=
				filemap_fdatawrite(inode->i_mapping);=0A=
				filemap_fdatawait(inode->i_mapping);=0A=
			/* temporarily disable caching while we=0A=
			go to server to get inode info */=0A=
				pCifsInode->clientCanCacheAll =3D FALSE;=0A=
				pCifsInode->clientCanCacheRead =3D FALSE;=0A=
				if (pTcon->ses->capabilities & CAP_UNIX)=0A=
					rc =3D cifs_get_inode_info_unix(&inode,=0A=
						full_path, inode->i_sb,xid);=0A=
				else=0A=
					rc =3D cifs_get_inode_info(&inode,=0A=
						full_path, NULL, inode->i_sb,xid);=0A=
			} /* else we are writing out data to server already=0A=
			and could deadlock if we tried to flush data, and =0A=
			since we do not know if we have data that would=0A=
			invalidate the current end of file on the server=0A=
			we can not go to the server to get the new=0A=
			inod info */=0A=
			if((oplock & 0xF) =3D=3D OPLOCK_EXCLUSIVE) {=0A=
				pCifsInode->clientCanCacheAll =3D  TRUE;=0A=
				pCifsInode->clientCanCacheRead =3D TRUE;=0A=
				cFYI(1,("Exclusive Oplock granted on inode =
%p",file->f_dentry->d_inode));=0A=
			} else if((oplock & 0xF) =3D=3D OPLOCK_READ) {=0A=
				pCifsInode->clientCanCacheRead =3D TRUE;=0A=
				pCifsInode->clientCanCacheAll =3D  FALSE;=0A=
			} else {=0A=
				pCifsInode->clientCanCacheRead =3D FALSE;=0A=
				pCifsInode->clientCanCacheAll =3D  FALSE;=0A=
			}=0A=
			cifs_relock_file(pCifsFile);=0A=
		}=0A=
	}=0A=
=0A=
	if (full_path)=0A=
		kfree(full_path);=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
int=0A=
cifs_close(struct inode *inode, struct file *file)=0A=
{=0A=
	int rc =3D 0;=0A=
	int xid;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	struct cifsFileInfo *pSMBFile =3D=0A=
		(struct cifsFileInfo *) file->private_data;=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	cifs_sb =3D CIFS_SB(inode->i_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
	if (pSMBFile) {=0A=
		pSMBFile->closePend    =3D TRUE;=0A=
		write_lock(&file->f_owner.lock);=0A=
		if(pTcon) {=0A=
			/* no sense reconnecting to close a file that is=0A=
				already closed */=0A=
			if (pTcon->tidStatus !=3D CifsNeedReconnect) {=0A=
				write_unlock(&file->f_owner.lock);=0A=
				rc =3D CIFSSMBClose(xid,pTcon,pSMBFile->netfid);=0A=
				write_lock(&file->f_owner.lock);=0A=
			}=0A=
		}=0A=
		list_del(&pSMBFile->flist);=0A=
		list_del(&pSMBFile->tlist);=0A=
		write_unlock(&file->f_owner.lock);=0A=
		if(pSMBFile->search_resume_name)=0A=
			kfree(pSMBFile->search_resume_name);=0A=
		kfree(file->private_data);=0A=
		file->private_data =3D NULL;=0A=
	} else=0A=
		rc =3D -EBADF;=0A=
=0A=
	if(list_empty(&(CIFS_I(inode)->openFileList))) {=0A=
		cFYI(1,("closing last open instance for inode %p",inode));=0A=
		/* if the file is not open we do not know if we can cache=0A=
		info on this inode, much less write behind and read ahead */=0A=
		CIFS_I(inode)->clientCanCacheRead =3D FALSE;=0A=
		CIFS_I(inode)->clientCanCacheAll  =3D FALSE;=0A=
	}=0A=
	if((rc =3D=3D0) && CIFS_I(inode)->write_behind_rc)=0A=
		rc =3D CIFS_I(inode)->write_behind_rc;=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
int=0A=
cifs_closedir(struct inode *inode, struct file *file)=0A=
{=0A=
	int rc =3D 0;=0A=
	int xid;=0A=
	struct cifsFileInfo *pSMBFileStruct =3D=0A=
	    (struct cifsFileInfo *) file->private_data;=0A=
=0A=
	cFYI(1, ("Closedir inode =3D 0x%p with ", inode));=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	if (pSMBFileStruct) {=0A=
		cFYI(1, ("Freeing private data in close dir"));=0A=
		kfree(file->private_data);=0A=
		file->private_data =3D NULL;=0A=
	}=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
int=0A=
cifs_lock(struct file *file, int cmd, struct file_lock *pfLock)=0A=
{=0A=
	int rc, xid;=0A=
	__u32 lockType =3D LOCKING_ANDX_LARGE_FILES;=0A=
	__u32 numLock =3D 0;=0A=
	__u32 numUnlock =3D 0;=0A=
	__u64 length;=0A=
	int wait_flag =3D FALSE;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	length =3D 1 + pfLock->fl_end - pfLock->fl_start;=0A=
=0A=
	rc =3D -EACCES;=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	cFYI(1,=0A=
	     ("Lock parm: 0x%x flockflags: 0x%x flocktype: 0x%x start: %lld =
end: %lld",=0A=
	      cmd, pfLock->fl_flags, pfLock->fl_type, pfLock->fl_start,=0A=
	      pfLock->fl_end));=0A=
=0A=
	if (pfLock->fl_flags & FL_POSIX)=0A=
		cFYI(1, ("Posix "));=0A=
	if (pfLock->fl_flags & FL_FLOCK)=0A=
		cFYI(1, ("Flock "));=0A=
	if (pfLock->fl_flags & FL_SLEEP) {=0A=
		cFYI(1, ("Blocking lock "));=0A=
		wait_flag =3D TRUE;=0A=
	}=0A=
	if (pfLock->fl_flags & FL_ACCESS)=0A=
		cFYI(1, ("Process suspended by mandatory locking - not implemented yet =
"));=0A=
	if (pfLock->fl_flags & FL_LEASE)=0A=
		cFYI(1, ("Lease on file - not implemented yet"));=0A=
	if (pfLock->fl_flags & (~(FL_POSIX | FL_FLOCK | FL_SLEEP | FL_ACCESS | =
FL_LEASE)))=0A=
		cFYI(1, ("Unknown lock flags 0x%x",pfLock->fl_flags));=0A=
=0A=
	if (pfLock->fl_type =3D=3D F_WRLCK) {=0A=
		cFYI(1, ("F_WRLCK "));=0A=
		numLock =3D 1;=0A=
	} else if (pfLock->fl_type =3D=3D F_UNLCK) {=0A=
		cFYI(1, ("F_UNLCK "));=0A=
		numUnlock =3D 1;=0A=
	} else if (pfLock->fl_type =3D=3D F_RDLCK) {=0A=
		cFYI(1, ("F_RDLCK "));=0A=
		lockType |=3D LOCKING_ANDX_SHARED_LOCK;=0A=
		numLock =3D 1;=0A=
	} else if (pfLock->fl_type =3D=3D F_EXLCK) {=0A=
		cFYI(1, ("F_EXLCK "));=0A=
		numLock =3D 1;=0A=
	} else if (pfLock->fl_type =3D=3D F_SHLCK) {=0A=
		cFYI(1, ("F_SHLCK "));=0A=
		lockType |=3D LOCKING_ANDX_SHARED_LOCK;=0A=
		numLock =3D 1;=0A=
	} else=0A=
		cFYI(1, ("Unknown type of lock "));=0A=
=0A=
	cifs_sb =3D CIFS_SB(file->f_dentry->d_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
=0A=
	if (file->private_data =3D=3D NULL) {=0A=
		FreeXid(xid);=0A=
		return -EBADF;=0A=
	}=0A=
=0A=
	if (IS_GETLK(cmd)) {=0A=
		rc =3D CIFSSMBLock(xid, pTcon,=0A=
				 ((struct cifsFileInfo *) file->=0A=
				  private_data)->netfid,=0A=
				 length,=0A=
				 pfLock->fl_start, 0, 1, lockType,=0A=
				 0 /* wait flag */ );=0A=
		if (rc =3D=3D 0) {=0A=
			rc =3D CIFSSMBLock(xid, pTcon,=0A=
					 ((struct cifsFileInfo *) file->=0A=
					  private_data)->netfid,=0A=
					 length,=0A=
					 pfLock->fl_start, 1 /* numUnlock */ ,=0A=
					 0 /* numLock */ , lockType,=0A=
					 0 /* wait flag */ );=0A=
			pfLock->fl_type =3D F_UNLCK;=0A=
			if (rc !=3D 0)=0A=
				cERROR(1,=0A=
					("Error unlocking previously locked range %d during test of lock ",=0A=
					rc));=0A=
			rc =3D 0;=0A=
=0A=
		} else {=0A=
			/* if rc =3D=3D ERR_SHARING_VIOLATION ? */=0A=
			rc =3D 0;	/* do not change lock type to unlock since range in use */=0A=
		}=0A=
=0A=
		FreeXid(xid);=0A=
		return rc;=0A=
	}=0A=
=0A=
	rc =3D CIFSSMBLock(xid, pTcon,=0A=
			 ((struct cifsFileInfo *) file->private_data)->=0A=
			 netfid, length,=0A=
			 pfLock->fl_start, numUnlock, numLock, lockType,=0A=
			 wait_flag);=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
ssize_t=0A=
cifs_write(struct file * file, const char *write_data,=0A=
	   size_t write_size, loff_t * poffset)=0A=
{=0A=
	int rc =3D 0;=0A=
	unsigned int bytes_written =3D 0;=0A=
	unsigned int total_written;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	int xid, long_op;=0A=
	struct cifsFileInfo * open_file;=0A=
=0A=
	if(file->f_dentry =3D=3D NULL)=0A=
		return -EBADF;=0A=
=0A=
	cifs_sb =3D CIFS_SB(file->f_dentry->d_sb);=0A=
	if(cifs_sb =3D=3D NULL) {=0A=
		return -EBADF;=0A=
	}=0A=
	pTcon =3D cifs_sb->tcon;=0A=
=0A=
	/*cFYI(1,=0A=
	   (" write %d bytes to offset %lld of %s", write_size,=0A=
	   *poffset, file->f_dentry->d_name.name)); */=0A=
=0A=
	if (file->private_data =3D=3D NULL) {=0A=
		return -EBADF;=0A=
	} else {=0A=
		open_file =3D (struct cifsFileInfo *) file->private_data;=0A=
	}=0A=
	=0A=
	xid =3D GetXid();=0A=
	if(file->f_dentry->d_inode =3D=3D NULL) {=0A=
		FreeXid(xid);=0A=
		return -EBADF;=0A=
	}=0A=
=0A=
	if (*poffset > file->f_dentry->d_inode->i_size)=0A=
		long_op =3D 2;  /* writes past end of file can take a long time */=0A=
	else=0A=
		long_op =3D 1;=0A=
=0A=
	for (total_written =3D 0; write_size > total_written;=0A=
	     total_written +=3D bytes_written) {=0A=
		rc =3D -EAGAIN;=0A=
		while(rc =3D=3D -EAGAIN) {=0A=
			if(file->private_data =3D=3D NULL) {=0A=
				/* file has been closed on us */=0A=
				FreeXid(xid);=0A=
			/* if we have gotten here we have written some data=0A=
			and blocked, and the file has been freed on us=0A=
			while we blocked so return what we managed to write */=0A=
				return total_written;=0A=
			} =0A=
			if(open_file->closePend) {=0A=
				FreeXid(xid);=0A=
				if(total_written)=0A=
					return total_written;=0A=
				else=0A=
					return -EBADF;=0A=
			}=0A=
			if (open_file->invalidHandle) {=0A=
				if((file->f_dentry =3D=3D NULL) ||=0A=
				   (file->f_dentry->d_inode =3D=3D NULL)) {=0A=
					FreeXid(xid);=0A=
					return total_written;=0A=
				}=0A=
				/* we could deadlock if we called=0A=
				 filemap_fdatawait from here so tell=0A=
				reopen_file not to flush data to server now */=0A=
				rc =3D cifs_reopen_file(file->f_dentry->d_inode,=0A=
					file,FALSE);=0A=
				if(rc !=3D 0)=0A=
					break;=0A=
			}=0A=
=0A=
			rc =3D CIFSSMBWrite(xid, pTcon,=0A=
				   open_file->netfid,=0A=
				  write_size - total_written, *poffset,=0A=
				  &bytes_written,=0A=
				  write_data + total_written, long_op);=0A=
		}=0A=
		if (rc || (bytes_written =3D=3D 0)) {=0A=
			if (total_written)=0A=
				break;=0A=
			else {=0A=
				FreeXid(xid);=0A=
				return rc;=0A=
			}=0A=
		} else=0A=
			*poffset +=3D bytes_written;=0A=
		long_op =3D FALSE; /* subsequent writes fast - 15 seconds is plenty */=0A=
	}=0A=
=0A=
#ifdef CONFIG_CIFS_STATS=0A=
	if(total_written > 0) {=0A=
		atomic_inc(&pTcon->num_writes);=0A=
		spin_lock(&pTcon->stat_lock);=0A=
		pTcon->bytes_written +=3D total_written;=0A=
		spin_unlock(&pTcon->stat_lock);=0A=
	}=0A=
#endif		=0A=
=0A=
	/* since the write may have blocked check these pointers again */=0A=
	if(file->f_dentry) {=0A=
		if(file->f_dentry->d_inode) {=0A=
			file->f_dentry->d_inode->i_ctime =3D file->f_dentry->d_inode->i_mtime =
=3D=0A=
				CURRENT_TIME;=0A=
			if (total_written > 0) {=0A=
				if (*poffset > file->f_dentry->d_inode->i_size)=0A=
					i_size_write(file->f_dentry->d_inode, *poffset);=0A=
			}=0A=
			mark_inode_dirty_sync(file->f_dentry->d_inode);=0A=
		}=0A=
	}=0A=
	FreeXid(xid);=0A=
	return total_written;=0A=
}=0A=
=0A=
static int=0A=
cifs_partialpagewrite(struct page *page,unsigned from, unsigned to)=0A=
{=0A=
	struct address_space *mapping =3D page->mapping;=0A=
	loff_t offset =3D (loff_t)page->index << PAGE_CACHE_SHIFT;=0A=
	char * write_data;=0A=
	int rc =3D -EFAULT;=0A=
	int bytes_written =3D 0;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	struct inode *inode;=0A=
	struct cifsInodeInfo *cifsInode;=0A=
	struct cifsFileInfo *open_file =3D NULL;=0A=
	struct list_head *tmp;=0A=
	struct list_head *tmp1;=0A=
=0A=
	if (!mapping) {=0A=
		return -EFAULT;=0A=
	} else if(!mapping->host) {=0A=
		return -EFAULT;=0A=
	}=0A=
=0A=
	inode =3D page->mapping->host;=0A=
	cifs_sb =3D CIFS_SB(inode->i_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
=0A=
	offset +=3D (loff_t)from;=0A=
	write_data =3D kmap(page);=0A=
	write_data +=3D from;=0A=
=0A=
	if((to > PAGE_CACHE_SIZE) || (from > to)) {=0A=
		kunmap(page);=0A=
		return -EIO;=0A=
	}=0A=
=0A=
	/* racing with truncate? */=0A=
	if(offset > mapping->host->i_size) {=0A=
		kunmap(page);=0A=
		return 0; /* don't care */=0A=
	}=0A=
=0A=
	/* check to make sure that we are not extending the file */=0A=
	if(mapping->host->i_size - offset < (loff_t)to)=0A=
		to =3D (unsigned)(mapping->host->i_size - offset); =0A=
		=0A=
=0A=
	cifsInode =3D CIFS_I(mapping->host);=0A=
	read_lock(&GlobalSMBSeslock); =0A=
	/* BB we should start at the end */=0A=
	list_for_each_safe(tmp, tmp1, &cifsInode->openFileList) {            =0A=
		open_file =3D list_entry(tmp,struct cifsFileInfo, flist);=0A=
		if(open_file->closePend)=0A=
			continue;=0A=
		/* We check if file is open for writing first */=0A=
		if((open_file->pfile) && =0A=
		   ((open_file->pfile->f_flags & O_RDWR) || =0A=
			(open_file->pfile->f_flags & O_WRONLY))) {=0A=
			read_unlock(&GlobalSMBSeslock);=0A=
			bytes_written =3D cifs_write(open_file->pfile, write_data,=0A=
					to-from, &offset);=0A=
			read_lock(&GlobalSMBSeslock);=0A=
		/* Does mm or vfs already set times? */=0A=
			inode->i_atime =3D inode->i_mtime =3D CURRENT_TIME;=0A=
			if ((bytes_written > 0) && (offset)) {=0A=
				rc =3D 0;=0A=
			} else if(bytes_written < 0) {=0A=
				if(rc =3D=3D -EBADF) {=0A=
				/* have seen a case in which=0A=
				kernel seemed to have closed/freed a file=0A=
				even with writes active so we might as well=0A=
				see if there are other file structs to try=0A=
				for the same inode before giving up */=0A=
					continue;=0A=
				} else=0A=
					rc =3D bytes_written;=0A=
			}=0A=
			break;  /* now that we found a valid file handle=0A=
				and tried to write to it we are done, no=0A=
				sense continuing to loop looking for another */=0A=
		}=0A=
		if(tmp->next =3D=3D NULL) {=0A=
			cFYI(1,("File instance %p removed",tmp));=0A=
			break;=0A=
		}=0A=
	}=0A=
	read_unlock(&GlobalSMBSeslock);=0A=
	if(open_file =3D=3D NULL) {=0A=
		cFYI(1,("No writeable filehandles for inode"));=0A=
		rc =3D -EIO;=0A=
	}=0A=
=0A=
	kunmap(page);=0A=
	return rc;=0A=
}=0A=
=0A=
#if 0=0A=
static int=0A=
cifs_writepages(struct address_space *mapping, struct writeback_control =
*wbc)=0A=
{=0A=
	int rc =3D -EFAULT;=0A=
	int xid;=0A=
=0A=
	xid =3D GetXid();=0A=
/* call 16K write then Setpageuptodate */=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
#endif=0A=
=0A=
static int=0A=
cifs_writepage(struct page* page, struct writeback_control *wbc)=0A=
{=0A=
	int rc =3D -EFAULT;=0A=
	int xid;=0A=
=0A=
	xid =3D GetXid();=0A=
/* BB add check for wbc flags */=0A=
	page_cache_get(page);=0A=
        if (!PageUptodate(page)) {=0A=
		cFYI(1,("ppw - page not up to date"));=0A=
	}=0A=
	=0A=
	rc =3D cifs_partialpagewrite(page,0,PAGE_CACHE_SIZE);=0A=
	SetPageUptodate(page); /* BB add check for error and Clearuptodate? */=0A=
	unlock_page(page);=0A=
	page_cache_release(page);	=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
static int=0A=
cifs_commit_write(struct file *file, struct page *page, unsigned offset,=0A=
		  unsigned to)=0A=
{=0A=
	int xid;=0A=
	int rc =3D 0;=0A=
	struct inode *inode =3D page->mapping->host;=0A=
	loff_t position =3D ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;=0A=
	char * page_data;=0A=
=0A=
	xid =3D GetXid();=0A=
	cFYI(1,("commit write for page %p up to position %lld for =
%d",page,position,to));=0A=
	if (position > inode->i_size){=0A=
		i_size_write(inode, position);=0A=
		/*if (file->private_data =3D=3D NULL) {=0A=
			rc =3D -EBADF;=0A=
		} else {=0A=
			open_file =3D (struct cifsFileInfo *)file->private_data;=0A=
			cifs_sb =3D CIFS_SB(inode->i_sb);=0A=
			rc =3D -EAGAIN;=0A=
			while(rc =3D=3D -EAGAIN) {=0A=
				if((open_file->invalidHandle) && =0A=
				  (!open_file->closePend)) {=0A=
					rc =3D cifs_reopen_file(file->f_dentry->d_inode,file);=0A=
					if(rc !=3D 0)=0A=
						break;=0A=
				}=0A=
				if(!open_file->closePend) {=0A=
					rc =3D CIFSSMBSetFileSize(xid, cifs_sb->tcon, =0A=
						position, open_file->netfid,=0A=
						open_file->pid,FALSE);=0A=
				} else {=0A=
					rc =3D -EBADF;=0A=
					break;=0A=
				}=0A=
			}=0A=
			cFYI(1,(" SetEOF (commit write) rc =3D %d",rc));=0A=
		}*/=0A=
	}=0A=
	if (!PageUptodate(page)) {=0A=
		position =3D  ((loff_t)page->index << PAGE_CACHE_SHIFT) + offset;=0A=
		/* can not rely on (or let) writepage write this data */=0A=
		if(to < offset) {=0A=
			cFYI(1,("Illegal offsets, can not copy from %d to %d",=0A=
				offset,to));=0A=
			FreeXid(xid);=0A=
			return rc;=0A=
		}=0A=
		/* this is probably better than directly calling =0A=
		partialpage_write since in this function=0A=
		the file handle is known which we might as well=0A=
		leverage */=0A=
		/* BB check if anything else missing out of ppw */=0A=
		/* such as updating last write time */=0A=
		page_data =3D kmap(page);=0A=
		rc =3D cifs_write(file, page_data+offset,to-offset,=0A=
                                        &position);=0A=
		if(rc > 0)=0A=
			rc =3D 0;=0A=
		/* else if rc < 0 should we set writebehind rc? */=0A=
		kunmap(page);=0A=
	} else {	=0A=
		set_page_dirty(page);=0A=
	}=0A=
=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
int=0A=
cifs_fsync(struct file *file, struct dentry *dentry, int datasync)=0A=
{=0A=
	int xid;=0A=
	int rc =3D 0;=0A=
	struct inode * inode =3D file->f_dentry->d_inode;=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	cFYI(1, ("Sync file - name: %s datasync: 0x%x ", =0A=
		dentry->d_name.name, datasync));=0A=
	=0A=
	rc =3D filemap_fdatawrite(inode->i_mapping);=0A=
	if(rc =3D=3D 0)=0A=
		CIFS_I(inode)->write_behind_rc =3D 0;=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
/* static int=0A=
cifs_sync_page(struct page *page)=0A=
{=0A=
	struct address_space *mapping;=0A=
	struct inode *inode;=0A=
	unsigned long index =3D page->index;=0A=
	unsigned int rpages =3D 0;=0A=
	int rc =3D 0;=0A=
=0A=
	cFYI(1,("sync page %p",page));=0A=
	mapping =3D page->mapping;=0A=
	if (!mapping)=0A=
		return 0;=0A=
	inode =3D mapping->host;=0A=
	if (!inode)=0A=
		return 0;*/=0A=
=0A=
/*	fill in rpages then =0A=
    result =3D cifs_pagein_inode(inode, index, rpages); *//* BB finish */=0A=
=0A=
/*   cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, =
index));=0A=
=0A=
	if (rc < 0)=0A=
		return rc;=0A=
	return 0;=0A=
} */=0A=
=0A=
/*=0A=
 * As file closes, flush all cached write data for this inode checking=0A=
 * for write behind errors.=0A=
 *=0A=
 */=0A=
int cifs_flush(struct file *file)=0A=
{=0A=
	struct inode * inode =3D file->f_dentry->d_inode;=0A=
	int rc =3D 0;=0A=
=0A=
	/* Rather than do the steps manually: */=0A=
	/* lock the inode for writing */=0A=
	/* loop through pages looking for write behind data (dirty pages) */=0A=
	/* coalesce into contiguous 16K (or smaller) chunks to write to server =
*/=0A=
	/* send to server (prefer in parallel) */=0A=
	/* deal with writebehind errors */=0A=
	/* unlock inode for writing */=0A=
	/* filemapfdatawrite appears easier for the time being */=0A=
=0A=
	rc =3D filemap_fdatawrite(inode->i_mapping);=0A=
	if(rc =3D=3D 0) /* reset wb rc if we were able to write out dirty pages =
*/=0A=
		CIFS_I(inode)->write_behind_rc =3D 0;=0A=
		=0A=
	cFYI(1,("Flush inode %p file %p rc %d",inode,file,rc));=0A=
=0A=
	return rc;=0A=
}=0A=
=0A=
=0A=
ssize_t=0A=
cifs_read(struct file * file, char *read_data, size_t read_size,=0A=
	  loff_t * poffset)=0A=
{=0A=
	int rc =3D -EACCES;=0A=
	unsigned int bytes_read =3D 0;=0A=
	unsigned int total_read;=0A=
	unsigned int current_read_size;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	int xid;=0A=
	char * current_offset;=0A=
	struct cifsFileInfo * open_file;=0A=
=0A=
	xid =3D GetXid();=0A=
	cifs_sb =3D CIFS_SB(file->f_dentry->d_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
=0A=
	if (file->private_data =3D=3D NULL) {=0A=
		FreeXid(xid);=0A=
		return -EBADF;=0A=
	}=0A=
	open_file =3D (struct cifsFileInfo *)file->private_data;=0A=
=0A=
	if((file->f_flags & O_ACCMODE) =3D=3D O_WRONLY) {=0A=
		cFYI(1,("attempting read on write only file instance"));=0A=
	}=0A=
=0A=
	for (total_read =3D 0,current_offset=3Dread_data; read_size > =
total_read;=0A=
				total_read +=3D bytes_read,current_offset+=3Dbytes_read) {=0A=
		current_read_size =3D min_t(const int,read_size - =
total_read,cifs_sb->rsize);=0A=
		rc =3D -EAGAIN;=0A=
		while(rc =3D=3D -EAGAIN) {=0A=
			if ((open_file->invalidHandle) && (!open_file->closePend)) {=0A=
				rc =3D cifs_reopen_file(file->f_dentry->d_inode,=0A=
					file,TRUE);=0A=
				if(rc !=3D 0)=0A=
					break;=0A=
			}=0A=
=0A=
			rc =3D CIFSSMBRead(xid, pTcon,=0A=
				 open_file->netfid,=0A=
				 current_read_size, *poffset,=0A=
				 &bytes_read, &current_offset);=0A=
		}=0A=
		if (rc || (bytes_read =3D=3D 0)) {=0A=
			if (total_read) {=0A=
				break;=0A=
			} else {=0A=
				FreeXid(xid);=0A=
				return rc;=0A=
			}=0A=
		} else {=0A=
#ifdef CONFIG_CIFS_STATS=0A=
			atomic_inc(&pTcon->num_reads);=0A=
			spin_lock(&pTcon->stat_lock);=0A=
			pTcon->bytes_read +=3D total_read;=0A=
			spin_unlock(&pTcon->stat_lock);=0A=
#endif=0A=
			*poffset +=3D bytes_read;=0A=
		}=0A=
	}=0A=
	FreeXid(xid);=0A=
	return total_read;=0A=
}=0A=
=0A=
int cifs_file_mmap(struct file * file, struct vm_area_struct * vma)=0A=
{=0A=
	struct dentry * dentry =3D file->f_dentry;=0A=
	int	rc, xid;=0A=
=0A=
	xid =3D GetXid();=0A=
	rc =3D cifs_revalidate(dentry);=0A=
	if (rc) {=0A=
		cFYI(1,("Validation prior to mmap failed, error=3D%d", rc));=0A=
		FreeXid(xid);=0A=
		return rc;=0A=
	}=0A=
	rc =3D generic_file_mmap(file, vma);=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
static void cifs_copy_cache_pages(struct address_space *mapping, =0A=
		struct list_head *pages, int bytes_read, =0A=
		char *data,struct pagevec * plru_pvec)=0A=
{=0A=
	struct page *page;=0A=
	char * target;=0A=
=0A=
	while (bytes_read > 0) {=0A=
		if(list_empty(pages))=0A=
			break;=0A=
=0A=
		page =3D list_entry(pages->prev, struct page, lru);=0A=
		list_del(&page->lru);=0A=
=0A=
		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {=0A=
			page_cache_release(page);=0A=
			cFYI(1,("Add page cache failed"));=0A=
			continue;=0A=
		}=0A=
=0A=
		target =3D kmap_atomic(page,KM_USER0);=0A=
=0A=
		if(PAGE_CACHE_SIZE > bytes_read) {=0A=
			memcpy(target,data,bytes_read);=0A=
			/* zero the tail end of this partial page */=0A=
			memset(target+bytes_read,0,PAGE_CACHE_SIZE-bytes_read);=0A=
			bytes_read =3D 0;=0A=
		} else {=0A=
			memcpy(target,data,PAGE_CACHE_SIZE);=0A=
			bytes_read -=3D PAGE_CACHE_SIZE;=0A=
		}=0A=
		kunmap_atomic(target,KM_USER0);=0A=
=0A=
		flush_dcache_page(page);=0A=
		SetPageUptodate(page);=0A=
		unlock_page(page);=0A=
		if (!pagevec_add(plru_pvec, page))=0A=
			__pagevec_lru_add(plru_pvec);=0A=
		data +=3D PAGE_CACHE_SIZE;=0A=
	}=0A=
	return;=0A=
}=0A=
=0A=
=0A=
int cifs_readpages_threadfn (void *data)=0A=
{=0A=
=0A=
int i, rc;=0A=
unsigned num_pages;=0A=
char *smb_read_data =3D NULL;=0A=
struct page *page;=0A=
=0A=
struct list_head page_list_head;=0A=
struct list_head *page_list;=0A=
=0A=
=0A=
struct per_thread_data *t =3D (struct per_thread_data *)data;=0A=
=0A=
while ( atomic_read(&t->pages_left) > 0 )=0A=
{=0A=
	=0A=
	INIT_LIST_HEAD(&page_list_head);=0A=
	=0A=
	if (atomic_read(&t->read_state) =3D=3D FIN_ERR || (t->interrupted =
=3D=3D 1)) break;=0A=
=0A=
=0A=
spin_lock(&t->sl_page_pool);=0A=
	=0A=
	if (atomic_read(&t->threads_required) < atomic_read(&t->thread_count)) {=0A=
		spin_unlock(&t->sl_page_pool);=0A=
		atomic_dec(&t->thread_count);=0A=
		return 0;=0A=
	}		=0A=
=0A=
	if (atomic_read(&t->read_state) =3D=3D FIN_ERR) /* if error */ {=0A=
		spin_unlock(&t->sl_page_pool);=0A=
		break;=0A=
	}=0A=
	/*	if(atomic_read(&t->thread_count)<=3D1) {=0A=
			atomic_dec(&t->thread_count);=0A=
			up(&t->threadsem);=0A=
			return 0;=0A=
		} else {=0A=
			atomic_dec(&t->thread_count);=0A=
			return 0;	=0A=
		}=0A=
	}*/=0A=
=0A=
	if (atomic_read(&t->read_state) =3D=3D FIN_WAIT) { /* endwait state */ =0A=
		if (atomic_read(&t->thread_count) <=3D 1) {=0A=
			spin_unlock(&t->sl_page_pool);=0A=
			atomic_dec(&t->thread_count);=0A=
			up(&t->threadsem);=0A=
			return 0;=0A=
		} else {=0A=
			atomic_dec(&t->thread_count);=0A=
			spin_unlock(&t->sl_page_pool);=0A=
			return 0;=0A=
		}=0A=
	}=0A=
=0A=
	//printk("\npages_left =3D %d\n", atomic_read(&t->pages_left));=0A=
	=0A=
	if (atomic_read(&t->pages_left) >=3D t->rsize_in_pages) {=0A=
		num_pages =3D t->rsize_in_pages;=0A=
	} else { =0A=
		num_pages =3D atomic_read(&t->pages_left);=0A=
	}=0A=
	=0A=
	//num_pages =3D 1;=0A=
	atomic_sub(num_pages, &t->pages_left);=0A=
=0A=
	for (i=3D0; i<num_pages; i++) {=0A=
		page =3D list_entry(t->page_pool, struct page, lru);=0A=
		t->page_pool =3D t->page_pool->prev;=0A=
		list_del(&page->lru);=0A=
		list_add(&page->lru, &page_list_head);	=0A=
	}=0A=
=0A=
	//printk("\npages_left now =3D %d\n", atomic_read(&t->pages_left));=0A=
=0A=
	if ( atomic_read(&t->pages_left) <=3D 0 ) =0A=
		atomic_set(&t->read_state, FIN_WAIT); /* set endwait state */=0A=
=0A=
spin_unlock(&t->sl_page_pool);=0A=
=0A=
	page_list =3D &page_list_head;	=0A=
=0A=
	for(i =3D 0; i < num_pages;) {=0A=
		struct page *tmp_page;=0A=
		unsigned contig_pages;=0A=
		unsigned long expected_index;=0A=
		loff_t offset;=0A=
		unsigned int read_size;=0A=
		int bytes_read;=0A=
		struct smb_com_read_rsp * pSMBr;	=0A=
		=0A=
		smb_read_data =3D NULL;=0A=
		=0A=
		=0A=
		page =3D list_entry(page_list->prev, struct page, lru);=0A=
		offset =3D (loff_t)page->index << PAGE_CACHE_SHIFT;=0A=
=0A=
		/* count adjacent pages that we will read into */=0A=
		contig_pages =3D 0;=0A=
		expected_index =3D list_entry(page_list->prev,struct page,lru)->index;	=
	=0A=
		list_for_each_entry_reverse(tmp_page, page_list,lru) {=0A=
			if(tmp_page->index =3D=3D expected_index) {=0A=
				contig_pages++;=0A=
				expected_index++;=0A=
			} else {=0A=
				break; =0A=
			}=0A=
		}=0A=
		//contig_pages =3D 1;=0A=
		=0A=
=0A=
		read_size =3D contig_pages * PAGE_CACHE_SIZE;=0A=
=0A=
		//printk("\nread_size =3D %d\n", read_size);=0A=
		=0A=
		if (atomic_read(&t->read_state) =3D=3D FIN_ERR) break;		=0A=
=0A=
		rc =3D -EAGAIN;=0A=
		while(rc =3D=3D -EAGAIN) {=0A=
			if ((t->open_file->invalidHandle) && (!t->open_file->closePend)) {=0A=
				rc =3D cifs_reopen_file(t->file->f_dentry->d_inode=0A=
							, t->file, TRUE);=0A=
				if(rc !=3D 0) {=0A=
					atomic_set((&t->read_state), FIN_ERR);=0A=
					break;=0A=
				}=0A=
			}=0A=
=0A=
			rc =3D CIFSSMBRead(t->xid, t->pTcon,=0A=
				t->open_file->netfid,=0A=
				read_size, offset,=0A=
				&bytes_read, &smb_read_data);=0A=
=0A=
			if(rc =3D=3D -EAGAIN) {=0A=
				if(smb_read_data) {=0A=
					cifs_buf_release(smb_read_data);=0A=
					smb_read_data =3D NULL;=0A=
				}=0A=
			}=0A=
		}=0A=
		=0A=
		if (atomic_read(&t->read_state) =3D=3D FIN_ERR) break;=0A=
		=0A=
		if ((rc < 0) || (smb_read_data =3D=3D NULL)) {=0A=
			cFYI(1,("Read error in readpages: %d",rc));=0A=
=0A=
			/* clean up remaing pages off list */=0A=
			atomic_set(&t->read_state, FIN_ERR);=0A=
			break;=0A=
		} else if (bytes_read > 0) {=0A=
			pSMBr =3D (struct smb_com_read_rsp *)smb_read_data;=0A=
			//printk("\nbefore cache\n");=0A=
			spin_lock(&t->sl_cache_lock);=0A=
			=0A=
			if (atomic_read(&t->read_state) =3D=3D FIN_ERR) {=0A=
				spin_unlock(&t->sl_cache_lock);=0A=
				break;=0A=
			}=0A=
			cifs_copy_cache_pages(t->mapping, page_list, =0A=
				bytes_read, smb_read_data + 4 /* RFC1001 hdr */=0A=
			 	+ le16_to_cpu(pSMBr->DataOffset),=0A=
				 &t->lru_pvec);=0A=
=0A=
			spin_unlock(&t->sl_cache_lock);=0A=
			//printk("\nafter cache\n");=0A=
=0A=
			i +=3D  bytes_read >> PAGE_CACHE_SHIFT;=0A=
#ifdef CONFIG_CIFS_STATS=0A=
			atomic_inc(&t->pTcon->num_reads);=0A=
			spin_lock(&t->pTcon->stat_lock);=0A=
			t->pTcon->bytes_read +=3D bytes_read;=0A=
			spin_unlock(&t->pTcon->stat_lock);=0A=
#endif=0A=
			if((int)(bytes_read & PAGE_CACHE_MASK) !=3D bytes_read) {=0A=
				cFYI(1,("Partial page %d of %d read to cache",=0A=
								i, num_pages));=0A=
=0A=
				i++; /* account for partial page */=0A=
=0A=
			}=0A=
		} else {=0A=
			cFYI(1,("No bytes read (%d) at offset %lld . Cleaning remaining pages =
from readahead list",bytes_read,offset)); =0A=
			atomic_set(&t->read_state, FIN_ERR);=0A=
			break;=0A=
		}=0A=
		if(smb_read_data) {=0A=
			cifs_buf_release(smb_read_data);=0A=
			smb_read_data =3D NULL;=0A=
		}=0A=
		bytes_read =3D 0;=0A=
=0A=
		if (atomic_read(&t->read_state) =3D=3D FIN_ERR) break;=0A=
		=0A=
	} //end of for(i =3D 0;i<num_pages;) =0A=
	=0A=
=0A=
	if (atomic_read(&t->read_state) =3D=3D FIN_ERR) break;=0A=
	=0A=
	if (atomic_read(&t->read_state) =3D=3D FIN_WAIT) {=0A=
		if (atomic_read(&t->thread_count) <=3D 1) {=0A=
			if(smb_read_data) {=0A=
				cifs_buf_release(smb_read_data);=0A=
				smb_read_data =3D NULL;=0A=
			}=0A=
			atomic_dec(&t->thread_count);=0A=
			up(&t->threadsem);=0A=
			return 0;=0A=
		} else {=0A=
			atomic_dec(&t->thread_count);=0A=
			return 0;=0A=
		}=0A=
	}=0A=
} // end of while=0A=
=0A=
if (atomic_read(&t->read_state) =3D=3D FIN_ERR || (t->interrupted =3D=3D =
1))  { /* if error */		=0A=
	if(smb_read_data) {=0A=
		cifs_buf_release(smb_read_data);=0A=
		smb_read_data =3D NULL;=0A=
	}=0A=
	atomic_dec(&t->thread_count);=0A=
	//printk("\nin tfn thread_count: %d\n", atomic_read(&t->thread_count)); =0A=
	if ( (t->interrupted =3D=3D 1) && (atomic_read(&t->thread_count) <=3D =
0) ) =0A=
		wake_up(&t->wq_h); =0A=
	up(&t->threadsem);=0A=
	return 0;=0A=
}=0A=
=0A=
atomic_dec(&t->thread_count);=0A=
//up(&t->threadsem);=0A=
return 0;=0A=
=0A=
}=0A=
=0A=
=0A=
=0A=
static int=0A=
cifs_readpages(struct file *file, struct address_space *mapping,=0A=
		struct list_head *page_list, unsigned num_pages)=0A=
{=0A=
	int i, init_threads, xid, rc =3D -EACCES;=0A=
	struct page *page;=0A=
	struct per_thread_data thread_data;=0A=
	=0A=
	/* some hard-coded rules to set initial no of threads=0A=
	 * no of threads are then later controlled by some=0A=
	 * other function which changes threads_required var=0A=
	 * to change no of threads running.=0A=
	 */=0A=
=0A=
	/* setting rsize to higher values at mount time inc performance */=0A=
	if (num_pages <=3D 4 )=0A=
		init_threads =3D 1;=0A=
	else if (num_pages <=3D 8)=0A=
		init_threads =3D 4;=0A=
	else init_threads =3D 8;=0A=
	// init_threads =3D 8;=0A=
=0A=
=0A=
	/* setting all the data to be passed to threads */=0A=
	xid =3D GetXid();=0A=
	thread_data.xid =3D xid; =0A=
	thread_data.sl_page_pool =3D SPIN_LOCK_UNLOCKED;=0A=
	thread_data.sl_cache_lock =3D SPIN_LOCK_UNLOCKED;=0A=
	thread_data.file =3D file;=0A=
	thread_data.mapping =3D mapping;=0A=
	thread_data.page_pool =3D page_list->prev;=0A=
=0A=
=0A=
	thread_data.open_file =3D (struct cifsFileInfo *)file->private_data;=0A=
	thread_data.cifs_sb =3D CIFS_SB(file->f_dentry->d_sb);=0A=
	thread_data.pTcon =3D thread_data.cifs_sb->tcon;=0A=
	thread_data.rsize_in_pages =3D (thread_data.cifs_sb->rsize) >> =
PAGE_CACHE_SHIFT;=0A=
	atomic_set(&thread_data.pages_left, num_pages);=0A=
	=0A=
	thread_data.interrupted =3D 0;=0A=
	init_waitqueue_head(&thread_data.wq_h);=0A=
=0A=
	/* read_state var --=0A=
	 * START (0)    : start the thread=0A=
	 * FIN_WAIT (1) : a thread has reached EOF =0A=
	 * FIN_END  (3) : some error occured during read=0A=
	 */=0A=
	atomic_set(&thread_data.read_state, 0);=0A=
=0A=
	/* keep track of current no of threads */=0A=
	atomic_set(&thread_data.thread_count, init_threads);=0A=
	=0A=
	/* var: threads_required - current no of threads required. =0A=
	 * This var is meant to be modified by some external=0A=
	 * function which determines current no of threads req=0A=
	 * acc to some criteria (such as variation in RTT over =0A=
	 * a certain period) and set it to this var.=0A=
	 * Threads read this var and stop if required.=0A=
	 * Increase in no of threads (if reqd) is work for the =0A=
	 * external function.=0A=
	 * Any such external function is not yet implemented.=0A=
	 */=0A=
	atomic_set(&thread_data.threads_required, init_threads);=0A=
=0A=
=0A=
	pagevec_init(&thread_data.lru_pvec, 0);=0A=
=0A=
	if (file->private_data =3D=3D NULL) {=0A=
		FreeXid(thread_data.xid);=0A=
		return -EBADF;=0A=
	}=0A=
	=0A=
	sema_init(&thread_data.threadsem, 1);=0A=
=0A=
	down_interruptible(&thread_data.threadsem); =0A=
	=0A=
	for (i=3D0; i<init_threads; i++)=0A=
		kthread_run(&cifs_readpages_threadfn, &thread_data, "cifsThread");=0A=
	=0A=
	if(down_interruptible(&thread_data.threadsem)) {=0A=
		thread_data.interrupted =3D 1;=0A=
		atomic_set(&thread_data.read_state, FIN_ERR);=0A=
		printk("\nCIFS: readpages interrupted by signal\n");=0A=
		sleep_on(&thread_data.wq_h);=0A=
=0A=
		while(!list_empty(page_list)) {=0A=
			page =3D list_entry(page_list->prev,struct page, lru);=0A=
			list_del(&page->lru);=0A=
			page_cache_release(page);=0A=
		}=0A=
		pagevec_lru_add(&thread_data.lru_pvec);=0A=
		FreeXid(thread_data.xid);=0A=
		return -ERESTARTSYS;	=0A=
	}=0A=
	=0A=
=0A=
	up(&thread_data.threadsem);		=0A=
	rc =3D 0;=0A=
	if (atomic_read(&thread_data.read_state) =3D=3D FIN_ERR) {=0A=
		rc =3D -EACCES;=0A=
		printk("\nCIFS: some error occured during reading\n");=0A=
		wait_event_interruptible(thread_data.wq_h, =
(atomic_read(&thread_data.thread_count) <=3D 0) );=0A=
		while(!list_empty(page_list)) {=0A=
			page =3D list_entry(page_list->prev,struct page, lru);=0A=
			list_del(&page->lru);=0A=
			page_cache_release(page);=0A=
		}=0A=
	}=0A=
=0A=
	pagevec_lru_add(&thread_data.lru_pvec);=0A=
=0A=
	FreeXid(thread_data.xid);=0A=
	return rc;=0A=
}=0A=
=0A=
=0A=
=0A=
=0A=
static int cifs_readpage_worker(struct file *file, struct page *page, =
loff_t * poffset)=0A=
{=0A=
	char * read_data;=0A=
	int rc;=0A=
=0A=
	page_cache_get(page);=0A=
	read_data =3D kmap(page);=0A=
	/* for reads over a certain size could initiate async read ahead */=0A=
                                                                         =
                                                  =0A=
	rc =3D cifs_read(file, read_data, PAGE_CACHE_SIZE, poffset);=0A=
                                                                         =
                                                  =0A=
	if (rc < 0)=0A=
		goto io_error;=0A=
	else {=0A=
		cFYI(1,("Bytes read %d ",rc));=0A=
	}=0A=
                                                                         =
                                                  =0A=
	file->f_dentry->d_inode->i_atime =3D CURRENT_TIME;=0A=
                                                                         =
                                                  =0A=
	if(PAGE_CACHE_SIZE > rc) {=0A=
		memset(read_data+rc, 0, PAGE_CACHE_SIZE - rc);=0A=
	}=0A=
	flush_dcache_page(page);=0A=
	SetPageUptodate(page);=0A=
	rc =3D 0;=0A=
                                                                         =
                                                  =0A=
io_error:=0A=
        kunmap(page);=0A=
	page_cache_release(page);=0A=
	return rc;=0A=
}=0A=
=0A=
static int=0A=
cifs_readpage(struct file *file, struct page *page)=0A=
{=0A=
	loff_t offset =3D (loff_t)page->index << PAGE_CACHE_SHIFT;=0A=
	int rc =3D -EACCES;=0A=
	int xid;=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	if (file->private_data =3D=3D NULL) {=0A=
		FreeXid(xid);=0A=
		return -EBADF;=0A=
	}=0A=
=0A=
	cFYI(1,("readpage %p at offset %d =
0x%x\n",page,(int)offset,(int)offset));=0A=
=0A=
	rc =3D cifs_readpage_worker(file,page,&offset);=0A=
=0A=
	unlock_page(page);=0A=
=0A=
	FreeXid(xid);=0A=
	return rc;=0A=
}=0A=
=0A=
/* We do not want to update the file size from server for inodes=0A=
   open for write - to avoid races with writepage extending=0A=
   the file - in the future we could consider allowing=0A=
   refreshing the inode only on increases in the file size =0A=
   but this is tricky to do without racing with writebehind=0A=
   page caching in the current Linux kernel design */=0A=
   =0A=
int is_size_safe_to_change(struct cifsInodeInfo * cifsInode)=0A=
{=0A=
	struct list_head *tmp;=0A=
	struct list_head *tmp1;=0A=
	struct cifsFileInfo *open_file =3D NULL;=0A=
	int rc =3D TRUE;=0A=
=0A=
	if(cifsInode =3D=3D NULL)=0A=
		return rc;=0A=
=0A=
	read_lock(&GlobalSMBSeslock); =0A=
	list_for_each_safe(tmp, tmp1, &cifsInode->openFileList) {            =0A=
		open_file =3D list_entry(tmp,struct cifsFileInfo, flist);=0A=
		if(open_file =3D=3D NULL)=0A=
			break;=0A=
		if(open_file->closePend)=0A=
			continue;=0A=
	/* We check if file is open for writing,   =0A=
	BB we could supplement this with a check to see if file size=0A=
	changes have been flushed to server - ie inode metadata dirty */=0A=
		if((open_file->pfile) && =0A=
	   ((open_file->pfile->f_flags & O_RDWR) || =0A=
		(open_file->pfile->f_flags & O_WRONLY))) {=0A=
			 rc =3D FALSE;=0A=
			 break;=0A=
		}=0A=
		if(tmp->next =3D=3D NULL) {=0A=
			cFYI(1,("File instance %p removed",tmp));=0A=
			break;=0A=
		}=0A=
	}=0A=
	read_unlock(&GlobalSMBSeslock);=0A=
	return rc;=0A=
}=0A=
=0A=
=0A=
void=0A=
fill_in_inode(struct inode *tmp_inode,=0A=
	      FILE_DIRECTORY_INFO * pfindData, int *pobject_type)=0A=
{=0A=
	struct cifsInodeInfo *cifsInfo =3D CIFS_I(tmp_inode);=0A=
	struct cifs_sb_info *cifs_sb =3D CIFS_SB(tmp_inode->i_sb);=0A=
=0A=
	pfindData->ExtFileAttributes =3D=0A=
	    le32_to_cpu(pfindData->ExtFileAttributes);=0A=
	pfindData->AllocationSize =3D le64_to_cpu(pfindData->AllocationSize);=0A=
	pfindData->EndOfFile =3D le64_to_cpu(pfindData->EndOfFile);=0A=
	cifsInfo->cifsAttrs =3D pfindData->ExtFileAttributes;=0A=
	cifsInfo->time =3D jiffies;=0A=
=0A=
	/* Linux can not store file creation time unfortunately so ignore it */=0A=
	tmp_inode->i_atime =3D=0A=
	    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastAccessTime));=0A=
	tmp_inode->i_mtime =3D=0A=
	    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastWriteTime));=0A=
	tmp_inode->i_ctime =3D=0A=
	    cifs_NTtimeToUnix(le64_to_cpu(pfindData->ChangeTime));=0A=
	/* treat dos attribute of read-only as read-only mode bit e.g. 555? */=0A=
	/* 2767 perms - indicate mandatory locking */=0A=
		/* BB fill in uid and gid here? with help from winbind? =0A=
			or retrieve from NTFS stream extended attribute */=0A=
	if(atomic_read(&cifsInfo->inUse) =3D=3D 0) {=0A=
		tmp_inode->i_uid =3D cifs_sb->mnt_uid;=0A=
		tmp_inode->i_gid =3D cifs_sb->mnt_gid;=0A=
		/* set default mode. will override for dirs below */=0A=
		tmp_inode->i_mode =3D cifs_sb->mnt_file_mode;=0A=
	}=0A=
=0A=
	cFYI(0,=0A=
	     ("CIFS FFIRST: Attributes came in as 0x%x",=0A=
	      pfindData->ExtFileAttributes));=0A=
	if (pfindData->ExtFileAttributes & ATTR_REPARSE) {=0A=
		*pobject_type =3D DT_LNK;=0A=
		/* BB can this and S_IFREG or S_IFDIR be set as in Windows? */=0A=
		tmp_inode->i_mode |=3D S_IFLNK;=0A=
	} else if (pfindData->ExtFileAttributes & ATTR_DIRECTORY) {=0A=
		*pobject_type =3D DT_DIR;=0A=
		/* override default perms since we do not lock dirs */=0A=
		if(atomic_read(&cifsInfo->inUse) =3D=3D 0) {=0A=
			tmp_inode->i_mode =3D cifs_sb->mnt_dir_mode;=0A=
		}=0A=
		tmp_inode->i_mode |=3D S_IFDIR;=0A=
	} else {=0A=
		*pobject_type =3D DT_REG;=0A=
		tmp_inode->i_mode |=3D S_IFREG;=0A=
		if(pfindData->ExtFileAttributes & ATTR_READONLY)=0A=
			tmp_inode->i_mode &=3D ~(S_IWUGO);=0A=
=0A=
	}/* could add code here - to validate if device or weird share type? */=0A=
=0A=
	/* can not fill in nlink here as in qpathinfo version and Unx search */=0A=
	if(atomic_read(&cifsInfo->inUse) =3D=3D 0) {=0A=
		atomic_set(&cifsInfo->inUse,1);=0A=
	}=0A=
=0A=
	if(is_size_safe_to_change(cifsInfo)) {=0A=
		/* can not safely change the file size here if the =0A=
		client is writing to it due to potential races */=0A=
		i_size_write(tmp_inode,pfindData->EndOfFile);=0A=
=0A=
	/* 512 bytes (2**9) is the fake blocksize that must be used */=0A=
	/* for this calculation, even though the reported blocksize is larger */=0A=
		tmp_inode->i_blocks =3D (512 - 1 + pfindData->AllocationSize) >> 9;=0A=
	}=0A=
=0A=
	if (pfindData->AllocationSize < pfindData->EndOfFile)=0A=
		cFYI(1, ("Possible sparse file: allocation size less than end of file =
"));=0A=
	cFYI(1,=0A=
	     ("File Size %ld and blocks %ld and blocksize %ld",=0A=
	      (unsigned long) tmp_inode->i_size, tmp_inode->i_blocks,=0A=
	      tmp_inode->i_blksize));=0A=
	if (S_ISREG(tmp_inode->i_mode)) {=0A=
		cFYI(1, (" File inode "));=0A=
		tmp_inode->i_op =3D &cifs_file_inode_ops;=0A=
		tmp_inode->i_fop =3D &cifs_file_ops;=0A=
		tmp_inode->i_data.a_ops =3D &cifs_addr_ops;=0A=
	} else if (S_ISDIR(tmp_inode->i_mode)) {=0A=
		cFYI(1, (" Directory inode"));=0A=
		tmp_inode->i_op =3D &cifs_dir_inode_ops;=0A=
		tmp_inode->i_fop =3D &cifs_dir_ops;=0A=
	} else if (S_ISLNK(tmp_inode->i_mode)) {=0A=
		cFYI(1, (" Symbolic Link inode "));=0A=
		tmp_inode->i_op =3D &cifs_symlink_inode_ops;=0A=
	} else {=0A=
		cFYI(1, (" Init special inode "));=0A=
		init_special_inode(tmp_inode, tmp_inode->i_mode,=0A=
				   tmp_inode->i_rdev);=0A=
	}=0A=
}=0A=
=0A=
void=0A=
unix_fill_in_inode(struct inode *tmp_inode,=0A=
		   FILE_UNIX_INFO * pfindData, int *pobject_type)=0A=
{=0A=
	struct cifsInodeInfo *cifsInfo =3D CIFS_I(tmp_inode);=0A=
	cifsInfo->time =3D jiffies;=0A=
	atomic_inc(&cifsInfo->inUse);=0A=
=0A=
	tmp_inode->i_atime =3D=0A=
	    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastAccessTime));=0A=
	tmp_inode->i_mtime =3D=0A=
	    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastModificationTime));=0A=
	tmp_inode->i_ctime =3D=0A=
	    cifs_NTtimeToUnix(le64_to_cpu(pfindData->LastStatusChange));=0A=
=0A=
	tmp_inode->i_mode =3D le64_to_cpu(pfindData->Permissions);=0A=
	pfindData->Type =3D le32_to_cpu(pfindData->Type);=0A=
	if (pfindData->Type =3D=3D UNIX_FILE) {=0A=
		*pobject_type =3D DT_REG;=0A=
		tmp_inode->i_mode |=3D S_IFREG;=0A=
	} else if (pfindData->Type =3D=3D UNIX_SYMLINK) {=0A=
		*pobject_type =3D DT_LNK;=0A=
		tmp_inode->i_mode |=3D S_IFLNK;=0A=
	} else if (pfindData->Type =3D=3D UNIX_DIR) {=0A=
		*pobject_type =3D DT_DIR;=0A=
		tmp_inode->i_mode |=3D S_IFDIR;=0A=
	} else if (pfindData->Type =3D=3D UNIX_CHARDEV) {=0A=
		*pobject_type =3D DT_CHR;=0A=
		tmp_inode->i_mode |=3D S_IFCHR;=0A=
		tmp_inode->i_rdev =3D MKDEV(le64_to_cpu(pfindData->DevMajor),=0A=
				le64_to_cpu(pfindData->DevMinor) & MINORMASK);=0A=
	} else if (pfindData->Type =3D=3D UNIX_BLOCKDEV) {=0A=
		*pobject_type =3D DT_BLK;=0A=
		tmp_inode->i_mode |=3D S_IFBLK;=0A=
		tmp_inode->i_rdev =3D MKDEV(le64_to_cpu(pfindData->DevMajor),=0A=
				le64_to_cpu(pfindData->DevMinor) & MINORMASK);=0A=
	} else if (pfindData->Type =3D=3D UNIX_FIFO) {=0A=
		*pobject_type =3D DT_FIFO;=0A=
		tmp_inode->i_mode |=3D S_IFIFO;=0A=
	} else if (pfindData->Type =3D=3D UNIX_SOCKET) {=0A=
		*pobject_type =3D DT_SOCK;=0A=
		tmp_inode->i_mode |=3D S_IFSOCK;=0A=
	}=0A=
=0A=
	tmp_inode->i_uid =3D le64_to_cpu(pfindData->Uid);=0A=
	tmp_inode->i_gid =3D le64_to_cpu(pfindData->Gid);=0A=
	tmp_inode->i_nlink =3D le64_to_cpu(pfindData->Nlinks);=0A=
=0A=
	pfindData->NumOfBytes =3D le64_to_cpu(pfindData->NumOfBytes);=0A=
=0A=
	if(is_size_safe_to_change(cifsInfo)) {=0A=
		/* can not safely change the file size here if the =0A=
		client is writing to it due to potential races */=0A=
		pfindData->EndOfFile =3D le64_to_cpu(pfindData->EndOfFile);=0A=
		i_size_write(tmp_inode,pfindData->EndOfFile);=0A=
=0A=
	/* 512 bytes (2**9) is the fake blocksize that must be used */=0A=
	/* for this calculation, not the real blocksize */=0A=
		tmp_inode->i_blocks =3D (512 - 1 + pfindData->NumOfBytes) >> 9;=0A=
	}=0A=
=0A=
	if (S_ISREG(tmp_inode->i_mode)) {=0A=
		cFYI(1, ("File inode"));=0A=
		tmp_inode->i_op =3D &cifs_file_inode_ops;=0A=
		tmp_inode->i_fop =3D &cifs_file_ops;=0A=
		tmp_inode->i_data.a_ops =3D &cifs_addr_ops;=0A=
	} else if (S_ISDIR(tmp_inode->i_mode)) {=0A=
		cFYI(1, ("Directory inode"));=0A=
		tmp_inode->i_op =3D &cifs_dir_inode_ops;=0A=
		tmp_inode->i_fop =3D &cifs_dir_ops;=0A=
	} else if (S_ISLNK(tmp_inode->i_mode)) {=0A=
		cFYI(1, ("Symbolic Link inode"));=0A=
		tmp_inode->i_op =3D &cifs_symlink_inode_ops;=0A=
/* tmp_inode->i_fop =3D *//* do not need to set to anything */=0A=
	} else {=0A=
		cFYI(1, ("Special inode")); =0A=
		init_special_inode(tmp_inode, tmp_inode->i_mode,=0A=
				   tmp_inode->i_rdev);=0A=
	}=0A=
}=0A=
=0A=
static void=0A=
construct_dentry(struct qstr *qstring, struct file *file,=0A=
		 struct inode **ptmp_inode, struct dentry **pnew_dentry)=0A=
{=0A=
	struct dentry *tmp_dentry;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
=0A=
	cFYI(1, ("For %s ", qstring->name));=0A=
	cifs_sb =3D CIFS_SB(file->f_dentry->d_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
=0A=
	qstring->hash =3D full_name_hash(qstring->name, qstring->len);=0A=
	tmp_dentry =3D d_lookup(file->f_dentry, qstring);=0A=
	if (tmp_dentry) {=0A=
		cFYI(0, (" existing dentry with inode 0x%p", tmp_dentry->d_inode));=0A=
		*ptmp_inode =3D tmp_dentry->d_inode;=0A=
		/* BB overwrite the old name? i.e. tmp_dentry->d_name and =
tmp_dentry->d_name.len ?? */=0A=
		if(*ptmp_inode =3D=3D NULL) {=0A=
	                *ptmp_inode =3D new_inode(file->f_dentry->d_sb);=0A=
			if(*ptmp_inode =3D=3D NULL)=0A=
				return;=0A=
			d_instantiate(tmp_dentry, *ptmp_inode);=0A=
			insert_inode_hash(*ptmp_inode);=0A=
		}=0A=
	} else {=0A=
		tmp_dentry =3D d_alloc(file->f_dentry, qstring);=0A=
		if(tmp_dentry =3D=3D NULL) {=0A=
			cERROR(1,("Failed allocating dentry"));=0A=
			*ptmp_inode =3D NULL;=0A=
			return;=0A=
		}=0A=
			=0A=
		*ptmp_inode =3D new_inode(file->f_dentry->d_sb);=0A=
		tmp_dentry->d_op =3D &cifs_dentry_ops;=0A=
		if(*ptmp_inode =3D=3D NULL)=0A=
			return;=0A=
		d_instantiate(tmp_dentry, *ptmp_inode);=0A=
		d_rehash(tmp_dentry);=0A=
		insert_inode_hash(*ptmp_inode);=0A=
	}=0A=
=0A=
	tmp_dentry->d_time =3D jiffies;=0A=
	*pnew_dentry =3D tmp_dentry;=0A=
}=0A=
=0A=
static void reset_resume_key(struct file * dir_file, =0A=
				unsigned char * filename, =0A=
				unsigned int len,int Unicode,struct nls_table * nls_tab) {=0A=
	struct cifsFileInfo *cifsFile;=0A=
=0A=
	cifsFile =3D (struct cifsFileInfo *)dir_file->private_data;=0A=
	if(cifsFile =3D=3D NULL)=0A=
		return;=0A=
	if(cifsFile->search_resume_name) {=0A=
		kfree(cifsFile->search_resume_name);=0A=
	}=0A=
=0A=
	if(Unicode) =0A=
		len *=3D 2;=0A=
	cifsFile->resume_name_length =3D len;=0A=
=0A=
	cifsFile->search_resume_name =3D =0A=
		kmalloc(cifsFile->resume_name_length, GFP_KERNEL);=0A=
=0A=
	if(cifsFile->search_resume_name =3D=3D NULL) {=0A=
		cERROR(1,("failed new resume key allocate, length %d",=0A=
				  cifsFile->resume_name_length));=0A=
		return;=0A=
	}=0A=
	if(Unicode)=0A=
		cifs_strtoUCS((wchar_t *) cifsFile->search_resume_name,=0A=
			filename, len, nls_tab);=0A=
	else=0A=
		memcpy(cifsFile->search_resume_name, filename, =0A=
		   cifsFile->resume_name_length);=0A=
	cFYI(1,("Reset resume key to: %s with len %d",filename,len));=0A=
	return;=0A=
}=0A=
=0A=
=0A=
=0A=
static int=0A=
cifs_filldir(struct qstr *pqstring, FILE_DIRECTORY_INFO * pfindData,=0A=
	     struct file *file, filldir_t filldir, void *direntry)=0A=
{=0A=
	struct inode *tmp_inode;=0A=
	struct dentry *tmp_dentry;=0A=
	int object_type,rc;=0A=
=0A=
	pqstring->name =3D pfindData->FileName;=0A=
	pqstring->len =3D pfindData->FileNameLength;=0A=
=0A=
	construct_dentry(pqstring, file, &tmp_inode, &tmp_dentry);=0A=
	if((tmp_inode =3D=3D NULL) || (tmp_dentry =3D=3D NULL)) {=0A=
		return -ENOMEM;=0A=
	}=0A=
	fill_in_inode(tmp_inode, pfindData, &object_type);=0A=
	rc =3D filldir(direntry, pfindData->FileName, pqstring->len, =
file->f_pos,=0A=
		tmp_inode->i_ino, object_type);=0A=
	if(rc) {=0A=
		/* due to readdir error we need to recalculate resume =0A=
		key so next readdir will restart on right entry */=0A=
		cFYI(1,("Error %d on filldir of %s",rc ,pfindData->FileName));=0A=
	}=0A=
	dput(tmp_dentry);=0A=
	return rc;=0A=
}=0A=
=0A=
static int=0A=
cifs_filldir_unix(struct qstr *pqstring,=0A=
		  FILE_UNIX_INFO * pUnixFindData, struct file *file,=0A=
		  filldir_t filldir, void *direntry)=0A=
{=0A=
	struct inode *tmp_inode;=0A=
	struct dentry *tmp_dentry;=0A=
	int object_type, rc;=0A=
=0A=
	pqstring->name =3D pUnixFindData->FileName;=0A=
	pqstring->len =3D strnlen(pUnixFindData->FileName, MAX_PATHCONF);=0A=
=0A=
	construct_dentry(pqstring, file, &tmp_inode, &tmp_dentry);=0A=
	if((tmp_inode =3D=3D NULL) || (tmp_dentry =3D=3D NULL)) {=0A=
		return -ENOMEM;=0A=
	}=0A=
=0A=
	unix_fill_in_inode(tmp_inode, pUnixFindData, &object_type);=0A=
	rc =3D filldir(direntry, pUnixFindData->FileName, pqstring->len,=0A=
		file->f_pos, tmp_inode->i_ino, object_type);=0A=
	if(rc) {=0A=
		/* due to readdir error we need to recalculate resume =0A=
			key so next readdir will restart on right entry */=0A=
		cFYI(1,("Error %d on filldir of %s",rc ,pUnixFindData->FileName));=0A=
	}=0A=
	dput(tmp_dentry);=0A=
	return rc;=0A=
}=0A=
=0A=
int=0A=
cifs_readdir(struct file *file, void *direntry, filldir_t filldir)=0A=
{=0A=
	int rc =3D 0;=0A=
	int xid;=0A=
	int Unicode =3D FALSE;=0A=
	int UnixSearch =3D FALSE;=0A=
	unsigned int bufsize, i;=0A=
	__u16 searchHandle;=0A=
	struct cifs_sb_info *cifs_sb;=0A=
	struct cifsTconInfo *pTcon;=0A=
	struct cifsFileInfo *cifsFile =3D NULL;=0A=
	char *full_path =3D NULL;=0A=
	char *data;=0A=
	struct qstr qstring;=0A=
	T2_FFIRST_RSP_PARMS findParms;=0A=
	T2_FNEXT_RSP_PARMS findNextParms;=0A=
	FILE_DIRECTORY_INFO *pfindData;=0A=
	FILE_DIRECTORY_INFO *lastFindData;=0A=
	FILE_UNIX_INFO *pfindDataUnix;=0A=
=0A=
	xid =3D GetXid();=0A=
=0A=
	cifs_sb =3D CIFS_SB(file->f_dentry->d_sb);=0A=
	pTcon =3D cifs_sb->tcon;=0A=
	bufsize =3D pTcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE;=0A=
	if(bufsize > CIFS_MAX_MSGSIZE) {=0A=
		FreeXid(xid);=0A=
		return -EIO;=0A=
	}=0A=
	data =3D kmalloc(bufsize, GFP_KERNEL);=0A=
	pfindData =3D (FILE_DIRECTORY_INFO *) data;=0A=
=0A=
	if(file->f_dentry =3D=3D NULL) {=0A=
		FreeXid(xid);=0A=
		return -EIO;=0A=
	}=0A=
	down(&file->f_dentry->d_sb->s_vfs_rename_sem);=0A=
	full_path =3D build_wildcard_path_from_dentry(file->f_dentry);=0A=
	up(&file->f_dentry->d_sb->s_vfs_rename_sem);=0A=
=0A=
=0A=
	cFYI(1, ("Full path: %s start at: %lld ", full_path, file->f_pos));=0A=
=0A=
	switch ((int) file->f_pos) {=0A=
	case 0:=0A=
		if (filldir(direntry, ".", 1, file->f_pos,=0A=
		     file->f_dentry->d_inode->i_ino, DT_DIR) < 0) {=0A=
			cERROR(1, ("Filldir for current dir failed "));=0A=
			break;=0A=
		}=0A=
		file->f_pos++;=0A=
		/* fallthrough */=0A=
	case 1:=0A=
		if (filldir(direntry, "..", 2, file->f_pos,=0A=
		     file->f_dentry->d_parent->d_inode->i_ino, DT_DIR) < 0) {=0A=
			cERROR(1, ("Filldir for parent dir failed "));=0A=
			break;=0A=
		}=0A=
		file->f_pos++;=0A=
		/* fallthrough */=0A=
	case 2:=0A=
		if (file->private_data !=3D NULL) {=0A=
			cifsFile =3D=0A=
				(struct cifsFileInfo *) file->private_data;=0A=
			if (cifsFile->endOfSearch) {=0A=
				if(cifsFile->emptyDir) {=0A=
					cFYI(1, ("End of search, empty dir"));=0A=
					rc =3D 0;=0A=
					break;=0A=
				}=0A=
			} else {=0A=
				cifsFile->invalidHandle =3D TRUE;=0A=
				CIFSFindClose(xid, pTcon, cifsFile->netfid);=0A=
			}=0A=
			if(cifsFile->search_resume_name) {=0A=
				kfree(cifsFile->search_resume_name);=0A=
				cifsFile->search_resume_name =3D NULL;=0A=
			}=0A=
		}=0A=
		rc =3D CIFSFindFirst(xid, pTcon, full_path, pfindData,=0A=
				&findParms, cifs_sb->local_nls,=0A=
				&Unicode, &UnixSearch);=0A=
		cFYI(1, ("Count: %d  End: %d ", findParms.SearchCount,=0A=
			findParms.EndofSearch));=0A=
 =0A=
		if (rc =3D=3D 0) {=0A=
			searchHandle =3D findParms.SearchHandle;=0A=
			if(file->private_data =3D=3D NULL)=0A=
				file->private_data =3D=0A=
					kmalloc(sizeof(struct cifsFileInfo),GFP_KERNEL);=0A=
			if (file->private_data) {=0A=
				memset(file->private_data, 0,=0A=
				       sizeof (struct cifsFileInfo));=0A=
				cifsFile =3D=0A=
				    (struct cifsFileInfo *) file->private_data;=0A=
				cifsFile->netfid =3D searchHandle;=0A=
				cifsFile->invalidHandle =3D FALSE;=0A=
				init_MUTEX(&cifsFile->fh_sem);=0A=
			} else {=0A=
				rc =3D -ENOMEM;=0A=
				break;=0A=
			}=0A=
=0A=
			renew_parental_timestamps(file->f_dentry);=0A=
			lastFindData =3D =0A=
				(FILE_DIRECTORY_INFO *) ((char *) pfindData + =0A=
					findParms.LastNameOffset);=0A=
			if((char *)lastFindData > (char *)pfindData + bufsize) {=0A=
				cFYI(1,("last search entry past end of packet"));=0A=
				rc =3D -EIO;=0A=
				break;=0A=
			}=0A=
			/* Offset of resume key same for levels 257 and 514 */=0A=
			cifsFile->resume_key =3D lastFindData->FileIndex;=0A=
			if(UnixSearch =3D=3D FALSE) {=0A=
				cifsFile->resume_name_length =3D =0A=
					le32_to_cpu(lastFindData->FileNameLength);=0A=
				if(cifsFile->resume_name_length > bufsize - 64) {=0A=
					cFYI(1,("Illegal resume file name length %d",=0A=
						cifsFile->resume_name_length));=0A=
					rc =3D -ENOMEM;=0A=
					break;=0A=
				}=0A=
				cifsFile->search_resume_name =3D =0A=
					kmalloc(cifsFile->resume_name_length, GFP_KERNEL);=0A=
				cFYI(1,("Last file: %s with name %d bytes long",=0A=
					lastFindData->FileName,=0A=
					cifsFile->resume_name_length));=0A=
				memcpy(cifsFile->search_resume_name,=0A=
					lastFindData->FileName, =0A=
					cifsFile->resume_name_length);=0A=
			} else {=0A=
				pfindDataUnix =3D (FILE_UNIX_INFO *)lastFindData;=0A=
				if (Unicode =3D=3D TRUE) {=0A=
					for(i=3D0;(pfindDataUnix->FileName[i] =0A=
						    | pfindDataUnix->FileName[i+1]);=0A=
						i+=3D2) {=0A=
						if(i > bufsize-64)=0A=
							break;=0A=
					}=0A=
					cifsFile->resume_name_length =3D i + 2;=0A=
				} else {=0A=
					cifsFile->resume_name_length =3D =0A=
						strnlen(pfindDataUnix->FileName,=0A=
							bufsize-63);=0A=
				}=0A=
				if(cifsFile->resume_name_length > bufsize - 64) {=0A=
					cFYI(1,("Illegal resume file name length %d",=0A=
						cifsFile->resume_name_length));=0A=
					rc =3D -ENOMEM;=0A=
					break;=0A=
				}=0A=
				cifsFile->search_resume_name =3D =0A=
					kmalloc(cifsFile->resume_name_length, GFP_KERNEL);=0A=
				cFYI(1,("Last file: %s with name %d bytes long",=0A=
					pfindDataUnix->FileName,=0A=
					cifsFile->resume_name_length));=0A=
				memcpy(cifsFile->search_resume_name,=0A=
					pfindDataUnix->FileName, =0A=
					cifsFile->resume_name_length);=0A=
			}=0A=
			for (i =3D 2; i < (unsigned int)findParms.SearchCount + 2; i++) {=0A=
				if (UnixSearch =3D=3D FALSE) {=0A=
					pfindData->FileNameLength =3D=0A=
					  le32_to_cpu(pfindData->FileNameLength);=0A=
					if (Unicode =3D=3D TRUE)=0A=
						pfindData->FileNameLength =3D=0A=
						    cifs_strfromUCS_le=0A=
						    (pfindData->FileName,=0A=
						     (wchar_t *)=0A=
						     pfindData->FileName,=0A=
						     (pfindData->=0A=
						      FileNameLength) / 2,=0A=
						     cifs_sb->local_nls);=0A=
					qstring.len =3D pfindData->FileNameLength;=0A=
					if (((qstring.len !=3D 1)=0A=
					     || (pfindData->FileName[0] !=3D '.'))=0A=
					    && ((qstring.len !=3D 2)=0A=
						|| (pfindData->=0A=
						    FileName[0] !=3D '.')=0A=
						|| (pfindData->=0A=
						    FileName[1] !=3D '.'))) {=0A=
						if(cifs_filldir(&qstring,=0A=
							     pfindData,=0A=
							     file, filldir,=0A=
							     direntry)) {=0A=
							/* do not end search if=0A=
								kernel not ready to take=0A=
								remaining entries yet */=0A=
							reset_resume_key(file, pfindData->FileName,qstring.len,=0A=
								Unicode, cifs_sb->local_nls);=0A=
							findParms.EndofSearch =3D 0;=0A=
							break;=0A=
						}=0A=
						file->f_pos++;=0A=
					}=0A=
				} else {	/* UnixSearch */=0A=
					pfindDataUnix =3D=0A=
					    (FILE_UNIX_INFO *) pfindData;=0A=
					if (Unicode =3D=3D TRUE)=0A=
						qstring.len =3D=0A=
							cifs_strfromUCS_le=0A=
							(pfindDataUnix->FileName,=0A=
							(wchar_t *)=0A=
							pfindDataUnix->FileName,=0A=
							MAX_PATHCONF,=0A=
							cifs_sb->local_nls);=0A=
					else=0A=
						qstring.len =3D=0A=
							strnlen(pfindDataUnix->=0A=
							  FileName,=0A=
							  MAX_PATHCONF);=0A=
					if (((qstring.len !=3D 1)=0A=
					     || (pfindDataUnix->=0A=
						 FileName[0] !=3D '.'))=0A=
					    && ((qstring.len !=3D 2)=0A=
						|| (pfindDataUnix->=0A=
						    FileName[0] !=3D '.')=0A=
						|| (pfindDataUnix->=0A=
						    FileName[1] !=3D '.'))) {=0A=
						if(cifs_filldir_unix(&qstring,=0A=
								  pfindDataUnix,=0A=
								  file,=0A=
								  filldir,=0A=
								  direntry)) {=0A=
							/* do not end search if=0A=
								kernel not ready to take=0A=
								remaining entries yet */=0A=
							findParms.EndofSearch =3D 0;=0A=
							reset_resume_key(file, pfindDataUnix->FileName,=0A=
								qstring.len,Unicode,cifs_sb->local_nls);=0A=
							break;=0A=
						}=0A=
						file->f_pos++;=0A=
					}=0A=
				}=0A=
				/* works also for Unix ff struct since first field of both */=0A=
				pfindData =3D =0A=
					(FILE_DIRECTORY_INFO *) ((char *) pfindData=0A=
						 + le32_to_cpu(pfindData->NextEntryOffset));=0A=
				/* BB also should check to make sure that pointer is not beyond the =
end of the SMB */=0A=
				/* if(pfindData > lastFindData) rc =3D -EIO; break; */=0A=
			}	/* end for loop */=0A=
			if ((findParms.EndofSearch !=3D 0) && cifsFile) {=0A=
				cifsFile->endOfSearch =3D TRUE;=0A=
				if(findParms.SearchCount =3D=3D 2)=0A=
					cifsFile->emptyDir =3D TRUE;=0A=
			}=0A=
		} else {=0A=
			if (cifsFile)=0A=
				cifsFile->endOfSearch =3D TRUE;=0A=
			/* unless parent directory gone do not return error */=0A=
			rc =3D 0;=0A=
		}=0A=
		break;=0A=
	default:=0A=
		if (file->private_data =3D=3D NULL) {=0A=
			rc =3D -EBADF;=0A=
			cFYI(1,=0A=
			     ("Readdir on closed srch, pos =3D %lld",=0A=
			      file->f_pos));=0A=
		} else {=0A=
			cifsFile =3D (struct cifsFileInfo *) file->private_data;=0A=
			if (cifsFile->endOfSearch) {=0A=
				rc =3D 0;=0A=
				cFYI(1, ("End of search "));=0A=
				break;=0A=
			}=0A=
			searchHandle =3D cifsFile->netfid;=0A=
			rc =3D CIFSFindNext(xid, pTcon, pfindData,=0A=
				&findNextParms, searchHandle, =0A=
				cifsFile->search_resume_name,=0A=
				cifsFile->resume_name_length,=0A=
				cifsFile->resume_key,=0A=
				&Unicode, &UnixSearch);=0A=
			cFYI(1,("Count: %d  End: %d ",=0A=
			      findNextParms.SearchCount,=0A=
			      findNextParms.EndofSearch));=0A=
			if ((rc =3D=3D 0) && (findNextParms.SearchCount !=3D 0)) {=0A=
			/* BB save off resume key, key name and name length  */=0A=
				lastFindData =3D =0A=
					(FILE_DIRECTORY_INFO *) ((char *) pfindData =0A=
						+ findNextParms.LastNameOffset);=0A=
				if((char *)lastFindData > (char *)pfindData + bufsize) {=0A=
					cFYI(1,("last search entry past end of packet"));=0A=
					rc =3D -EIO;=0A=
					break;=0A=
				}=0A=
				/* Offset of resume key same for levels 257 and 514 */=0A=
				cifsFile->resume_key =3D lastFindData->FileIndex;=0A=
=0A=
				if(UnixSearch =3D=3D FALSE) {=0A=
					cifsFile->resume_name_length =3D =0A=
						le32_to_cpu(lastFindData->FileNameLength);=0A=
					if(cifsFile->resume_name_length > bufsize - 64) {=0A=
						cFYI(1,("Illegal resume file name length %d",=0A=
							cifsFile->resume_name_length));=0A=
						rc =3D -ENOMEM;=0A=
						break;=0A=
					}=0A=
					/* Free the memory allocated by previous findfirst =0A=
					or findnext call - we can not reuse the memory since=0A=
					the resume name may not be same string length */=0A=
					if(cifsFile->search_resume_name)=0A=
						kfree(cifsFile->search_resume_name);=0A=
					cifsFile->search_resume_name =3D =0A=
						kmalloc(cifsFile->resume_name_length, GFP_KERNEL);=0A=
					cFYI(1,("Last file: %s with name %d bytes long",=0A=
						lastFindData->FileName,=0A=
						cifsFile->resume_name_length));=0A=
					memcpy(cifsFile->search_resume_name,=0A=
						lastFindData->FileName, =0A=
						cifsFile->resume_name_length);=0A=
				} else {=0A=
					pfindDataUnix =3D (FILE_UNIX_INFO *)lastFindData;=0A=
					if (Unicode =3D=3D TRUE) {=0A=
						for(i=3D0;(pfindDataUnix->FileName[i] =0A=
								| pfindDataUnix->FileName[i+1]);=0A=
							i+=3D2) {=0A=
							if(i > bufsize-64)=0A=
								break;=0A=
						}=0A=
						cifsFile->resume_name_length =3D i + 2;=0A=
					} else {=0A=
						cifsFile->resume_name_length =3D =0A=
							strnlen(pfindDataUnix->=0A=
							 FileName,=0A=
							 MAX_PATHCONF);=0A=
					}=0A=
					if(cifsFile->resume_name_length > bufsize - 64) {=0A=
						cFYI(1,("Illegal resume file name length %d",=0A=
								cifsFile->resume_name_length));=0A=
						rc =3D -ENOMEM;=0A=
						break;=0A=
					}=0A=
					/* Free the memory allocated by previous findfirst =0A=
					or findnext call - we can not reuse the memory since=0A=
					the resume name may not be same string length */=0A=
					if(cifsFile->search_resume_name)=0A=
						kfree(cifsFile->search_resume_name);=0A=
					cifsFile->search_resume_name =3D =0A=
						kmalloc(cifsFile->resume_name_length, GFP_KERNEL);=0A=
					cFYI(1,("fnext last file: %s with name %d bytes long",=0A=
						pfindDataUnix->FileName,=0A=
						cifsFile->resume_name_length));=0A=
					memcpy(cifsFile->search_resume_name,=0A=
						pfindDataUnix->FileName, =0A=
						cifsFile->resume_name_length);=0A=
				}=0A=
=0A=
				for (i =3D 0; i < findNextParms.SearchCount; i++) {=0A=
					pfindData->FileNameLength =3D=0A=
					    le32_to_cpu(pfindData->=0A=
							FileNameLength);=0A=
					if (UnixSearch =3D=3D FALSE) {=0A=
						if (Unicode =3D=3D TRUE)=0A=
							pfindData->FileNameLength =3D=0A=
							  cifs_strfromUCS_le=0A=
							  (pfindData->FileName,=0A=
							  (wchar_t *)=0A=
							  pfindData->FileName,=0A=
							  (pfindData->FileNameLength)/ 2,=0A=
							  cifs_sb->local_nls);=0A=
						qstring.len =3D =0A=
							pfindData->FileNameLength;=0A=
						if (((qstring.len !=3D 1)=0A=
						    || (pfindData->FileName[0] !=3D '.'))=0A=
						    && ((qstring.len !=3D 2)=0A=
							|| (pfindData->FileName[0] !=3D '.')=0A=
							|| (pfindData->FileName[1] !=3D=0A=
							    '.'))) {=0A=
							if(cifs_filldir=0A=
							    (&qstring,=0A=
							     pfindData,=0A=
							     file, filldir,=0A=
							     direntry)) {=0A=
							/* do not end search if=0A=
								kernel not ready to take=0A=
								remaining entries yet */=0A=
								findNextParms.EndofSearch =3D 0;=0A=
								reset_resume_key(file, pfindData->FileName,qstring.len,=0A=
									Unicode,cifs_sb->local_nls);=0A=
								break;=0A=
							}=0A=
							file->f_pos++;=0A=
						}=0A=
					} else {	/* UnixSearch */=0A=
						pfindDataUnix =3D=0A=
						    (FILE_UNIX_INFO *)=0A=
						    pfindData;=0A=
						if (Unicode =3D=3D TRUE)=0A=
							qstring.len =3D=0A=
							  cifs_strfromUCS_le=0A=
							  (pfindDataUnix->FileName,=0A=
							  (wchar_t *)=0A=
							  pfindDataUnix->FileName,=0A=
							  MAX_PATHCONF,=0A=
							  cifs_sb->local_nls);=0A=
						else=0A=
							qstring.len =3D=0A=
							  strnlen=0A=
							  (pfindDataUnix->=0A=
							  FileName,=0A=
							  MAX_PATHCONF);=0A=
						if (((qstring.len !=3D 1)=0A=
						     || (pfindDataUnix->=0A=
							 FileName[0] !=3D '.'))=0A=
						    && ((qstring.len !=3D 2)=0A=
							|| (pfindDataUnix->=0A=
							    FileName[0] !=3D '.')=0A=
							|| (pfindDataUnix->=0A=
							    FileName[1] !=3D=0A=
							    '.'))) {=0A=
							if(cifs_filldir_unix=0A=
							    (&qstring,=0A=
							     pfindDataUnix,=0A=
							     file, filldir,=0A=
							     direntry)) {=0A=
								/* do not end search if=0A=
								kernel not ready to take=0A=
								remaining entries yet */=0A=
								findNextParms.EndofSearch =3D 0;=0A=
								reset_resume_key(file, pfindDataUnix->FileName,qstring.len,=0A=
									Unicode,cifs_sb->local_nls);=0A=
								break;=0A=
							}=0A=
							file->f_pos++;=0A=
						}=0A=
					}=0A=
					pfindData =3D (FILE_DIRECTORY_INFO *) ((char *) pfindData + =0A=
						le32_to_cpu(pfindData->NextEntryOffset));=0A=
	/* works also for Unix find struct since first field of both */=0A=
	/* BB also should check to ensure pointer not beyond end of SMB */=0A=
				} /* end for loop */=0A=
				if (findNextParms.EndofSearch !=3D 0) {=0A=
					cifsFile->endOfSearch =3D TRUE;=0A=
				}=0A=
			} else {=0A=
				cifsFile->endOfSearch =3D TRUE;=0A=
				rc =3D 0;	/* unless parent directory disappeared - do not=0A=
				return error here (eg Access Denied or no more files) */=0A=
			}=0A=
		}=0A=
	} /* end switch */=0A=
	if (data)=0A=
		kfree(data);=0A=
	if (full_path)=0A=
		kfree(full_path);=0A=
	FreeXid(xid);=0A=
=0A=
	return rc;=0A=
}=0A=
int cifs_prepare_write(struct file *file, struct page *page,=0A=
			unsigned from, unsigned to)=0A=
{=0A=
	int rc =3D 0;=0A=
        loff_t offset =3D (loff_t)page->index << PAGE_CACHE_SHIFT;=0A=
	cFYI(1,("prepare write for page %p from %d to %d",page,from,to));=0A=
	if (!PageUptodate(page)) {=0A=
	/*	if (to - from !=3D PAGE_CACHE_SIZE) {=0A=
			void *kaddr =3D kmap_atomic(page, KM_USER0);=0A=
			memset(kaddr, 0, from);=0A=
			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);=0A=
			flush_dcache_page(page);=0A=
			kunmap_atomic(kaddr, KM_USER0);=0A=
		} */=0A=
		/* If we are writing a full page it will be up to date,=0A=
		no need to read from the server */=0A=
		if((to=3D=3DPAGE_CACHE_SIZE) && (from =3D=3D 0))=0A=
			SetPageUptodate(page);=0A=
=0A=
		/* might as well read a page, it is fast enough */=0A=
		if((file->f_flags & O_ACCMODE) !=3D O_WRONLY) {=0A=
			rc =3D cifs_readpage_worker(file,page,&offset);=0A=
		} else {=0A=
		/* should we try using another=0A=
		file handle if there is one - how would we lock it=0A=
		to prevent close of that handle racing with this read? */=0A=
		/* In any case this will be written out by commit_write */=0A=
		}=0A=
	}=0A=
=0A=
	/* BB should we pass any errors back? e.g. if we do not have read =
access to the file */=0A=
	return 0;=0A=
}=0A=
=0A=
=0A=
struct address_space_operations cifs_addr_ops =3D {=0A=
	.readpage =3D cifs_readpage,=0A=
	.readpages =3D cifs_readpages,=0A=
	.writepage =3D cifs_writepage,=0A=
	.prepare_write =3D cifs_prepare_write, =0A=
	.commit_write =3D cifs_commit_write,=0A=
	.set_page_dirty =3D __set_page_dirty_nobuffers,=0A=
   /* .sync_page =3D cifs_sync_page, */=0A=
	/*.direct_IO =3D */=0A=
};=0A=

------=_NextPart_000_0000_01C50760.90604410--
