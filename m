Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUAZTBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUAZTBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:01:09 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:23757 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263851AbUAZTBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:01:00 -0500
Message-ID: <40156449.8010805@namesys.com>
Date: Mon, 26 Jan 2004 11:02:33 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>, mahalcro@us.ibm.com,
       linux-kernel@vger.kernel.org, edward@namesys.com
Subject: Encrypted Filesystem
References: <16405.24299.945548.174085@laputa.namesys.com>
In-Reply-To: <16405.24299.945548.174085@laputa.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would encourage you to look at reiser4's encryption plugin.  It is 
currently able to perform most of the actions required to compile a 
kernel without crashing.;-)  Edward can provide more details.  Note that 
we encrypt and compress not with every write, but with every flush to 
disk, and this makes it reasonable to compress and encrypt everything 
routinely.

Probably it will be working soon, and definitely it could use another 
person working on it.  Note that the same framework also provides file 
compression, and we are hoping that on machines with a good ratio of CPU 
power to disk bandwidth we can actually increase performance as a result 
of using it.

Current reiser4 benchmarks without it are at 
www.namesys.com/benchmarks.html, and reiser4 is described at www.namesys.com

Hans

Nikita Danilov wrote:

 >
 > -------------------------
 >
 > Subject:
 > Encrypted Filesystem
 > From:
 > Michael A Halcrow <mahalcro@us.ibm.com>
 > Date:
 > Mon, 26 Jan 2004 11:46:29 -0600
 > To:
 > linux-kernel@vger.kernel.org
 >
 >

> I have some time this year to work on an encrypted filesystem for
> Linux.  I have surveyed various LUG's, tested and reviewed code for
> currently existing implementations, and have started modifying some
> of them.  I would like to settle on a single approach on which to
> focus my efforts, and I am interested in getting feedback from the
> LKML community as to which approach is the most feasible.
>
> This is the feature wish-list that I have compiled, based on personal
> experience and feedback I have received from other individuals and
> groups:
>
>  - Seamless application to the root filesystem
>   - Layered over the entire root filesystem
>   - Unencrypted pass-through mode with minimal overhead
>   - Files are marked as  ``encrypted'' or ``unencrypted'' and treated
>     accordingly by the encryption layer
>  - Key->file association
>   - As opposed to key->blkdev or key->directory granularity
>   - No encryption metafiles in directories, instead placing that
>     information into Extended Attributes
>   - May break some backup utilities that are not EA-aware; may require
>     another mode where encryption metadata is stored in a header block
>     on the encrypted file
>   - Directories can be flagged as ``encrypted-only'', where any new
>     files created in that directory are, by default, encrypted, with
>     the key and permissions defined in the directory's metadata
>   - Processes may have encryption contexts, whereby any new files they
>     create are encrypted by default according to the process'
>     authentication
>   - Make as much metadata about the file as confidential as possible
>     (filesize, executable bit, etc.)
>  - Pluggable encryption (I wouldn't mind using a block cipher in CTR
>    mode)
>  - Authentication via PAM
>   - pam_usb
>   - Bluetooth
>   - Kerberos
>   - PAM checks for group membership before allowing access to certain
>     encrypted files
>  - Rootplug-based LSM to provide key management (necessary to use
>    LSM?)
>  - Secret splitting and/or (m,n)-threshold support on the keys
>  - Signatures on files flagged for auditing in order to detect
>    attempts to circumvent the encryption layer (via direct
>    modifications to the files themselves in the underlying filesystem)
>  - Ad-hoc groups for access to decrypted versions of files
>   - i.e., launch web browser, drop group membership by default (like
>     capability inheritance masks) so that the browser does not have
>     access to decrypted files by default; PAM module checks for group
>     membership before allowing access (explicit user authorization on
>     application access requests)
>  - Userland utilities to support encrypted file management
>  - Extensions to nautilus and konqueror to be able to use these
>    utilities from a common interface (think: right-click, encrypted)
>  - Distro installation integration
>  - Transparent shredding, where the underlying filesystem supports it
>  - Versioning and snapshots (CVS-ish behavior)
>  - Design to work w/ SE Linux
>
> These are features that have been requested, but are not necessarily
> hard requirements for the encrypted filesystem.  They are just
> suggestions that I have received, and I am not convinced that they are
> all feasible.
>
> There are several potential approaches to an encrypted filesystem with
> these features, all with varying degrees of modification to the kernel
> itself, each with its own set of advantages and disadvantages.
>
> Options that I am aware of include:
>
>  - NFS-based (CFS, TCFS)
>   - CFS is mature
>   - Performance issues
>   - Violates UNIX semantics w/ hole behavior
>   - Single-threaded
>
>  - Userland filesystem-based (EncFS+FUSE, CryptoFS+LUFS)
>   - Newer solutions, not as well accepted or tested as CFS
>   - KDE team is using SSHFS+FUSE
>
>  - Loopback (cryptoloop) encrypted block device
>   - Mature; in the kernel
>   - Block device granularity; breaks most incremental backup
>     applications
>
>  - LSM-based
>   - Is this even possible?  Are the hooks that we need there?
>
>  - Modifications to VFS (stackable filesystem, like NCryptfs)
>   - Very low overhead claimed by Erez Zadok
>   - Full implementation not released
>   - Key->directory granularity
>   - Evicts cleartext pages from the cache on process death
>   - Uses dcache to store attaches
>   - Other niceties, but it's not released...
>
> My goal is to develop an encrypted filesystem ``for the desktop'',
> where a user can right-click on a file in konqueror or nautilus and
> check the ``encrypted'' box, and all subsequent accesses by any
> processes to that file will require authentication in order for the
> file to be decrypted.  I have already made some modifications to CFS
> to support this functionality, but I am not sure at this moment
> whether or not CFS is the best route to go for this.
>
> I have had requests to write a kernel module that, when loaded,
> transparently starts acting as the encryption layer on top of whatever
> root filesystem is mounted.  For example, an ext3 partition may have
> encrypted files strewn about, which are accessible only after loading
> the module (and authenticating, etc.).
>
> Any advise or direction that the kernel community could provide would
> be very much appreciated.
>
> Thanks,
> Mike
> .___________________________________________________________________.
>                          Michael A. Halcrow
>        Security Software Engineer, IBM Linux Technology Center
> GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



