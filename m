Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130071AbQHWRRR>; Wed, 23 Aug 2000 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130070AbQHWRRI>; Wed, 23 Aug 2000 13:17:08 -0400
Received: from ix.netcorps.com ([207.1.125.106]:19636 "EHLO ix.netcorps.com") by vger.kernel.org with ESMTP id <S130068AbQHWRQ4>; Wed, 23 Aug 2000 13:16:56 -0400
Message-ID: <39A402E9.9845852F@timpanogas.com>
Date: Wed, 23 Aug 2000 10:59:22 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: NTFS primer - was: Re: NTFS-like streams?
References: <4.3.2.7.2.20000822194733.00b3a960@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton,

I think the original intent here was to provide a semantic for folks
porting from NT to use the attribute mechanism the way NTFS does for
data mining apps, etc.  I think the best approach here is for apps to
use an ioctl() to the FS to get to the attributes and tell developers to
change their code, since this is more natural to Linux.  The attribute
access method needs to be FS dependent and exposed via the VFS if they
want to do it the other way.  I have implemented my NTFS driver this way
on Linux.  I am nearing completion of a full driver for MANOS with a
backport to Linux.  There is still some legal issues with us putting up
on Linux, but I am working these.

I am going out with the ioctl() call for now -- seems to be the easiest
way.  They can try to munge in the ':' or '~' thing, but it's going to
be a shitload of works and bugs all over the place....

BTW.  If you want to own the NTFS code base I publish on MANOS and
Linux, you can take it over when it's posted.  I hope you had a great
vacation.  Hey!  Where's the NTFS repair tool for Linux you were working
on?:-) :-) 

:-)

Your friend,

Jeff

Anton Altaparmakov wrote:
> 
> Sorry for bringing this thread back into life but after having spent the
> past 5 or so hours reading its contents I feel it is necessary, since many
> people don't seem to understand/know about NTFS and hence a lot of wrong /
> pointless posts were made. - Obviously my holiday was badly timed... )-:
> 
> Here is a very basic summary of NTFS concepts which will, I hope, explain
> why most approaches that have been outlined to sort out the streams/EAs
> problem in Linux cannot work. - A very important point is the fact that a
> stream is not an EA and neither of those is a user defined attribute. -
> However NTFS supports all of them!
> 
> NTFS concepts+clear ups
> -----------------------
> 
> 0. The NTFS file system is a relational database of file records. (These
> are stored in the $MFT file record. - Yes, the file system is really
> recursive! Even the boot sector is a file and has a file record in the
> $MFT, admittedly with a fixed on disk location...)
> 
> 1. A file record (aka file) is a structured list of attributes (such as:
> NTFS filename, MS DOS filename, Posix filename, standard file information,
> security descriptor, named data attribute [aka streams], HPFS extended
> attributes [aka EAs], user defined attributes [aka what some people call
> extended attributes], quota information, symbolic link information, mount
> point information, directory index information, directory index entry,
> unique object Id, etc. - Note, this is somewhat simplified and many of
> those attributes are actually one and the same/multiple copies of the same
> but with different contents.)[Note, that the data parts of each of those
> attributes is not necessarily stored in the file record itself.]
> 
> 2. A directory is a file (and hence can have all possible attributes a
> normal file can have - a nameless data attribute is not permitted however).
> The filename of the root directory is "\". A directory file record contains
> a list of index entries pointing to file records in the $MFT.
> 
> 3. The streams people have been referring to are attributes of type $Data
> with a specific name (e.g. file_name:data_attribute_name). The "normal"
> file-contents people usually talk about are represented by a nameless $Data
> attribute (name length = 0). These streams are used for implementing the
> HFS file system on top of NTFS [done by the Macintosh services for NT].
> 
> 4. The EAs most people have been referring to are attributes of type $EA
> and are used mainly for HPFS compatibility.
> 
> 5. User defined attributes are extensions to the file system and require a
> file system filter to be added to the running kernel to deal with them. -
> These are intended as non-MS extensions to NTFS.
> 
> 6. The reparse point attribute is used in Win2k (NTFS v3.0) for symbolic
> links and mount points.
> 
> 7. Name space for filenames: there are three of them. MSDOS compatible
> short names, Win32/NT compatible long names and Posix filenames. While
> MSDOS and Win32/NT filenames coexist happily (and in fact MSDOS names are
> auto generated for each Win32/NT long filename), a file with a Posix
> filename will be invisible to all of the Windows NT tools which do not
> specifically use the Posix subsystem. No auto generation of other names is
> performed here.
> 
> 8. Hard links are Posix compliant and are implemented by having several
> filename attributes in a file record (one for each hard link) and by having
> the same file record being referenced by different directory index entries
> (again, one for each hard link). - Thus when deleting files what happens is
> that you delete the directory index record + filename attribute and if no
> more filename attributes are present you then proceed to actually deleting
> the file.
> 
> Conclusions
> -----------
> You don't want to start emulating EAs using streams or vice versa since
> they are distinct entities.
> 
> While the colon approach would work for streams as it does in WinNT it
> doesn't cover EAs at all and in fact it can't do that. - A attr_{get,set}
> API or an attr_ops structure (or something else?) will be required for EAs.
> - I certainly can't see any way you can fuse the two together but I would
> be happy to be shown the light. (-;
> 
> The only problem with the colon approach I can see is that Linux/UNIX
> actually allow colon as a valid character in a file name. This will at the
> very least cause massive confusion among end users. - Imagine Joe Doe with
> a ext2 partition having named his/her mp3 files in the form: albumname:
> songname.mp3. Joe then copies the files to an NTFS partition and does "ls"
> and sees only one file called albumname with zero size (NTFS parsed the
> colon to mean file albumname and named data attribute songname.mp3 for each
> songname.mp3). At this point Joe panics and dies of a heart attack... )-:
> 
> And yes, the file size displayed in the command prompt when using the dir
> command in NT only counts up the size of the unnamed data attribute...
> 
> That's all for now!
> 
> <please flame off list>
> 
> Regards,
> 
>         Anton
> --
> 
>       "Education is what remains after one has forgotten everything he
> learned in school." - Albert Einstein
> 
> --
> Anton Altaparmakov  Voice: 01223-333541(lab) / 07712-632205(mobile)
> Christ's College    eMail: AntonA@bigfoot.com
> Cambridge CB2 3BU    ICQ: 8561279
> United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
