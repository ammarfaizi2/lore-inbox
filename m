Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129575AbQJ0V4s>; Fri, 27 Oct 2000 17:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbQJ0V4i>; Fri, 27 Oct 2000 17:56:38 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:30214 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129575AbQJ0V41>;
	Fri, 27 Oct 2000 17:56:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Date: Fri, 27 Oct 2000 23:54:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B2D168F210B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Oct 00 at 15:14, Jeff V. Merkey wrote:
> Petr Vandrovec wrote:
> > 
> > On 27 Oct 00 at 13:46, Jeff V. Merkey wrote:
> > > Here's the complete set of 3.x/4.x/5.x Namespace NCP calls with proper
> > > return codes.  I'll run down the huge-data info and post a bit later.
> > 
> > Thanks. Main problem with hardlinks is that unlink through NFS namespace
> > kills server (at least up to 5.0, I did not checked it during last few
> > months), and unlink through DOS (or OS2) namespace removes all instances
> > of hardlinked file :-( A bit unfortunate behavior.
> 
> Where are you doing this in the code?  I'll go look at it and attempt a
> fix.  It's killing the server because the linkage fields are probably
> not getting set.  If NFSSERV is loaded, and the

In kernel fs/ncpfs/ncplib_kernel.c, there is function named 
ncp_del_file_or_subdir() which does:

#ifdef CONFIG_NCPFS_NFS_NS
  if (server->name_space[volnum] == NW_NS_NFS)
  {
    int result;
    
    result = ncp_obtain_DOS_dir_base(server, volnum, dirent, name, &dirent);
    if (result) return result;
    return ncp_DeleteNSEntry(server, 1, volnum, dirent, NULL, NW_NS_DOS,
       htons(0x0680));
  }
  else
#endif
    return ncp_DeleteNSEntry(server, 1, volnum, dirent, name, 
       server->name_space[volnum], htons(0x0680));

If you'll remove #ifdef-ed part, and you'll try to unlink some file
using NFS namespace, server dies (on traditional filesystem, NSS works)
with some internal inconsistency found error. Depending on search
attributes (0x8006) passed to function, it either works only for directories
(and abend for files), or works only for dirs (and refuses files), or
does not work at all.
      
> links ever get hosed, you will get an Abend on 3.x and 4.x, and a
> "process suspended" error on 5.x (which also hangs the server).  If the

It is always without any modifications through NFS namespace info, as
I'm not using it at all.

> also because these linkage fields are not getting set properly.  It does
> not work this way 
> with the NetWare NFSSERV.NLM mounted as an NFS client from Linux.

NUC interface is also OK (as unixware happily uses that), only NCP 87,8
is broken. I did not ever tried to unlink file if NFSSERV is loaded...
 
> > > 2222/6804       Return Bindery Context (you need to implement this one
> > > -- I did not see it in your code)
> > 
> > ncpfs 2.2.0.18 implements this (lib/ds/bindctx.c:NWDSGetBinderyContext),
> > but does not use it itself...
> 
> It should.  It will allow you to use NDS with your existing code and NCP
> suite.  I guess 
> doug's next project at TRG will be to put in NDS support in NCPFS and
> submit the patches to you.

ncpfs (2.2.0.18/2.2.0.19pre) supports almost complete documented NWDS* 
set of functions. Only thing missing are ACL assigning code, you must
do it yourself through NWDSModifyObject calls.

> > Userspace ncpfs (specifically ncopy) uses
> > (lib/filemgmt.c:ncp_ns_open_create_entry) NCP 87,30 or 87,33 for this
> > (and NW3.x is out of luck, AFAIK). Kernel code does not support MAC
> > forks (and ACL and extended attributes), as up to now there is no
> > vfs API for this... You have to use ncopy,nwdir/nwrights,
> > nwtrustee,...,nwdir/eaops,nwdir for accessing MAC(&FTAM)/ACL/EAs for now.
> > (for EAs you must have post-August 27 ncpfs, betas are on
> > ftp://platan.vc.cvut.cz/private/ncpfs)
> 
> You can expose these as .files the way HFS likes to see them, and MAC
> clients to a Linux box 
> will be able to see and store their data in native MAC format -- with
> finder info.

It is possible when using DOS or OS/2 namespace. But as NFS namespace 
allows all byte sequences up to 255 chars for filename (excluding chars
0, '/' and names "." and "..")...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
