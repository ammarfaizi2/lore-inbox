Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUAZTHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUAZTHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:07:48 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:50633 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264455AbUAZTHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:07:30 -0500
Message-ID: <40156546.1050809@borgerding.net>
Date: Mon, 26 Jan 2004 14:06:46 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Michael A Halcrow <mahalcro@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
In-Reply-To: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds like you've got a nice methodical approach: gathering 
requirements and thinking about it before diving headlong into hacking.

Iterative development works well for a lot of things (obviously), but I 
think that crypto work requires a little bit of Cathedral-esque 
architecture in order to be secure.  It would pay off to think long and 
hard about feedback modes, IVs, key management, salting, etc. ;  before 
doing any coding. 
Posting explanations in sci.crypt would find a good deal more scrutiny 
(read: paranoia) than in lkml.  Bounce kernel & fs ideas off the kernel 
hackers. Bounce crypto ideas off the cryptographers.


Some random thoughts:

Have you given any thought to journalling? fscking? Can directory 
contents be encrypted?  If so, what does the dir look like to others 
(e.g. backup utils)

Per-file signatures will severely affect random access performance.  
Changing 1 byte in a 1 GB file would require the whole thing to be reread.

Why tackle versioning?   If you want encrypted cvs, you could run cvs in 
file mode with the repository and/or modules in encrypted files.

CTR mode (or any stream cipher) would be more susceptible to bit 
twiddling than CBC. If sigs are not integral to fs, this would be a problem.

Adding the functionality to a well known fs like ext3 or reiserfs might 
be a good path to faster acceptance. It would get a lot more people 
looking at the code.  It would also allow people to start using the new 
features on existing partitions just by patching the kernel.


I'd love to help out.  I have some exp with crypto, and a teensy bit of 
exp with linux filesystems.  How much time I may actually have to 
contribute depends on far too many factors to guess.


- Mark Borgerding





Michael A Halcrow wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>I have some time this year to work on an encrypted filesystem for
>Linux.  I have surveyed various LUG's, tested and reviewed code for
>currently existing implementations, and have started modifying some
>of them.  I would like to settle on a single approach on which to
>focus my efforts, and I am interested in getting feedback from the
>LKML community as to which approach is the most feasible.
>
>This is the feature wish-list that I have compiled, based on personal
>experience and feedback I have received from other individuals and
>groups:
>
> - Seamless application to the root filesystem
>  - Layered over the entire root filesystem
>  - Unencrypted pass-through mode with minimal overhead
>  - Files are marked as  ``encrypted'' or ``unencrypted'' and treated
>    accordingly by the encryption layer
> - Key->file association
>  - As opposed to key->blkdev or key->directory granularity
>  - No encryption metafiles in directories, instead placing that
>    information into Extended Attributes
>  - May break some backup utilities that are not EA-aware; may require
>    another mode where encryption metadata is stored in a header block
>    on the encrypted file
>  - Directories can be flagged as ``encrypted-only'', where any new
>    files created in that directory are, by default, encrypted, with
>    the key and permissions defined in the directory's metadata
>  - Processes may have encryption contexts, whereby any new files they
>    create are encrypted by default according to the process'
>    authentication
>  - Make as much metadata about the file as confidential as possible
>    (filesize, executable bit, etc.)
> - Pluggable encryption (I wouldn't mind using a block cipher in CTR
>   mode)
> - Authentication via PAM
>  - pam_usb
>  - Bluetooth
>  - Kerberos
>  - PAM checks for group membership before allowing access to certain
>    encrypted files
> - Rootplug-based LSM to provide key management (necessary to use
>   LSM?)
> - Secret splitting and/or (m,n)-threshold support on the keys
> - Signatures on files flagged for auditing in order to detect
>   attempts to circumvent the encryption layer (via direct
>   modifications to the files themselves in the underlying filesystem)
> - Ad-hoc groups for access to decrypted versions of files
>  - i.e., launch web browser, drop group membership by default (like
>    capability inheritance masks) so that the browser does not have
>    access to decrypted files by default; PAM module checks for group
>    membership before allowing access (explicit user authorization on
>    application access requests)
> - Userland utilities to support encrypted file management
> - Extensions to nautilus and konqueror to be able to use these
>   utilities from a common interface (think: right-click, encrypted)
> - Distro installation integration
> - Transparent shredding, where the underlying filesystem supports it
> - Versioning and snapshots (CVS-ish behavior)
> - Design to work w/ SE Linux
>
>These are features that have been requested, but are not necessarily
>hard requirements for the encrypted filesystem.  They are just
>suggestions that I have received, and I am not convinced that they are
>all feasible.
>
>There are several potential approaches to an encrypted filesystem with
>these features, all with varying degrees of modification to the kernel
>itself, each with its own set of advantages and disadvantages.
>
>Options that I am aware of include:
>
> - NFS-based (CFS, TCFS)
>  - CFS is mature
>  - Performance issues
>  - Violates UNIX semantics w/ hole behavior
>  - Single-threaded
>
> - Userland filesystem-based (EncFS+FUSE, CryptoFS+LUFS)
>  - Newer solutions, not as well accepted or tested as CFS
>  - KDE team is using SSHFS+FUSE
>
> - Loopback (cryptoloop) encrypted block device
>  - Mature; in the kernel
>  - Block device granularity; breaks most incremental backup
>    applications
>
> - LSM-based
>  - Is this even possible?  Are the hooks that we need there?
>
> - Modifications to VFS (stackable filesystem, like NCryptfs)
>  - Very low overhead claimed by Erez Zadok
>  - Full implementation not released
>  - Key->directory granularity
>  - Evicts cleartext pages from the cache on process death
>  - Uses dcache to store attaches
>  - Other niceties, but it's not released...
>
>My goal is to develop an encrypted filesystem ``for the desktop'',
>where a user can right-click on a file in konqueror or nautilus and
>check the ``encrypted'' box, and all subsequent accesses by any
>processes to that file will require authentication in order for the
>file to be decrypted.  I have already made some modifications to CFS
>to support this functionality, but I am not sure at this moment
>whether or not CFS is the best route to go for this.
>
>I have had requests to write a kernel module that, when loaded,
>transparently starts acting as the encryption layer on top of whatever
>root filesystem is mounted.  For example, an ext3 partition may have
>encrypted files strewn about, which are accessible only after loading
>the module (and authenticating, etc.).
>
>Any advise or direction that the kernel community could provide would
>be very much appreciated.
>
>Thanks,
>Mike
>.___________________________________________________________________.
>                         Michael A. Halcrow 
>       Security Software Engineer, IBM Linux Technology Center 
>GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.0.6 (GNU/Linux)
>Comment: For info see http://www.gnupg.org
>
>iD8DBQFAFU9wLTz92j62YB0RAkOfAKClVMzKIhw6JtyGvKf8+iFp4e12AwCdFARU
>uAhpA7wVjvPMdDQtKSnFzzI=
>=TM5Y
>-----END PGP SIGNATURE-----
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


