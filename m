Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbQJ0WgH>; Fri, 27 Oct 2000 18:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129229AbQJ0Wf7>; Fri, 27 Oct 2000 18:35:59 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:55047 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129197AbQJ0Wfd>; Fri, 27 Oct 2000 18:35:33 -0400
Message-ID: <39FA025C.673118C8@timpanogas.org>
Date: Fri, 27 Oct 2000 16:31:56 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
In-Reply-To: <B2D168F210B@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr Vandrovec wrote:
> 
>
> 
> In kernel fs/ncpfs/ncplib_kernel.c, there is function named
> ncp_del_file_or_subdir() which does:
> 
> #ifdef CONFIG_NCPFS_NFS_NS
>   if (server->name_space[volnum] == NW_NS_NFS)
>   {
>     int result;
> 
>     result = ncp_obtain_DOS_dir_base(server, volnum, dirent, name, &dirent);
>     if (result) return result;
>     return ncp_DeleteNSEntry(server, 1, volnum, dirent, NULL, NW_NS_DOS,
>        htons(0x0680));

What wrong here is you have to read in each NS record (and the records
for the parent
file) and modify them.  You are just doing one and expecting the server
to do the work
of unlinking just the one.  You have to do each link yourself.  I will
fix.


>   }
>   else
> #endif
>     return ncp_DeleteNSEntry(server, 1, volnum, dirent, name,
>        server->name_space[volnum], htons(0x0680));
> 
> If you'll remove #ifdef-ed part, and you'll try to unlink some file
> using NFS namespace, server dies (on traditional filesystem, NSS works)
> with some internal inconsistency found error. Depending on search
> attributes (0x8006) passed to function, it either works only for directories
> (and abend for files), or works only for dirs (and refuses files), or
> does not work at all.
> 
>
> > You can expose these as .files the way HFS likes to see them, and MAC
> > clients to a Linux box
> > will be able to see and store their data in native MAC format -- with
> > finder info.
> 
> It is possible when using DOS or OS/2 namespace. But as NFS namespace
> allows all byte sequences up to 255 chars for filename (excluding chars
> 0, '/' and names "." and "..")...

I have code that translates MAC to DOS, DOS to NFS, NFS to MAC, etc.  
You have to convert the
names using the tables in NWFS, file NWCREATE.C.  There are tables I use
to generate the 
MAC names from an NFS name using these tables of valid and invalid
characters for each
namespace.  I have to do it for all the server Namespaces, since Netware
can cross mount 
NWFS volumes created under Linux.

Jeff

>                                             Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
