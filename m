Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281212AbRKLB5y>; Sun, 11 Nov 2001 20:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281216AbRKLB5r>; Sun, 11 Nov 2001 20:57:47 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:51386 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281212AbRKLB5a>; Sun, 11 Nov 2001 20:57:30 -0500
Message-Id: <5.1.0.14.2.20011112012026.02b3eda8@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 12 Nov 2001 01:57:28 +0000
To: "Tim R." <omarvo@hotmail.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC][PATCH] extended attributes
Cc: linux-kernel@vger.kernel.org, nathans@sgi.com
In-Reply-To: <3BECEEA2.4030408@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:08 10/11/2001, Tim R. wrote:
>I'm glad to see you guys are working on a common acl api for ext2/3 and xfs.
>I was just wondering if this api provided what would be needed for linux 
>to support NTFS's acls.
>Now bare in mind I know little about how NTFS's alc's are implimented or 
>if they follow POSIX at
>all. But I just thought it might be worth asking the ntfs maintainer if 
>the proposed api would be
>adaquit to support ntfs's acls on linux should they ever want to impliment 
>this. Might save them
>headaches someday.

Comments/problems for NTFS with proposed EA/ACL API:

I think the API is good for extended attributes, no doubt. If we ever get 
round to implementing EAs in NTFS then I would be happy to use the API. It 
fully satisfies the needs of the NTFS EAs. The only addition I would put 
into the API is that the names of the extended attributes have to be able 
to have different name spaces themselves. For example I am fairly sure that 
the name of an EA in NTFS cannot contain just any character and it 
certainly cannot have a name of any length... This is something that needs 
to be considered. At least there must be a defined error return values of 
"EILSEQ" (bad name namespace) and "ENAMETOOLONG" (self evident).

But for ACLs I am not so positive:

I guess the real problem is that NTFS security doesn't map very well onto 
Unix/Linux type of security model because the NTFS model has way more features.

If you are asking the question whether NTFS can work with the proposed API 
then yes, it can support all its features, but not the other way round...

Particular problems:

- The proposed API puts ACLs inside extended attributes (EAs). On NTFS ACLs 
have nothing to do with extended attributes. They are two entirely 
different things. I suppose they could be merged into one API and the NTFS 
driver would have to parse and decide whether it is supposed to be 
operating on ACLs or EAs. But that will be a pain, especially as there may 
be ways of abusing the system, depending on how exactly it is implemented.

- The ACLs in NTFS are _way_ more complex than the suggested ones. So 
mapping from one to the other is possible only when creating new files. 
When reading/writing existing ACLs a lot of information would be lost.

Further each inode has a "user" owner and a group "owner" plus two types of 
ACLs: system one (SACL) and discretionary "normal" one (DACL).

These four thigns are stored within a self relative security descriptor. 
And some of them are optional or can be inherited from parent inode or can 
be defaulted. - This actually breaks the current API which says that files 
cannot inherit/default file ACLs. In NTFS they can.

The actual permissions in NTFS are not just RWX but they are a lot more 
granular (a 32 bitfield, see below URL for a list of all defined values) 
and some of them even determine the access rights to extended attributes, 
which needless to say causes a problem if ACLs are treated as EAs...

- NTFS doesn't store uids but Security Identifiers (SID ones not 
Security_ID ones, both are separate things on NTFS. Are you confused yet? I 
am...) so mapping would need to exist between NTFS SID and Linux UIDs. 
Samba needs to do this (and does it already AFAIK), too, but that is more a 
problem of NTFS and not a Linux ACL API.

All NTFS security stuff can be seen at the following URL - just search for 
IDENTIFIER_AUTHORITY and read from there on... all security related 
structures are defined there and there are quite a few comments.

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/linux-ntfs/ntfs-driver-tng/linux/include/linux/ntfs_layout.h?rev=1.11&content-type=text/vnd.viewcvs-markup

You can also read the NTFS documentation on SF but note that this is not as 
complete as the header file above but it might be easier to understand. The 
url with the description of the security descriptor is:

http://linux-ntfs.sourceforge.net/ntfs/attributes/security_descriptor.html

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

