Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUA0S4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUA0S4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:56:37 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:43236 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265363AbUA0S4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:56:05 -0500
Message-ID: <4016B444.A816C980@namesys.com>
Date: Tue, 27 Jan 2004 21:56:04 +0300
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>, mahalcro@us.ibm.com
CC: Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
References: <16405.24299.945548.174085@laputa.namesys.com> <40156449.8010805@namesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> I would encourage you to look at reiser4's encryption plugin.  It is
> currently able to perform most of the actions required to compile a
> kernel without crashing.;-)  Edward can provide more details.  Note that
> we encrypt and compress not with every write, but with every flush to
> disk, and this makes it reasonable to compress and encrypt everything
> routinely.
> 
> Probably it will be working soon, and definitely it could use another
> person working on it.  Note that the same framework also provides file
> compression, and we are hoping that on machines with a good ratio of CPU
> power to disk bandwidth we can actually increase performance as a result
> of using it.

Yes. Also IBM's laptop hard disk space is too expensive, so I have presented
to myself T41 with only 40GB (5400rpm) HDD, keeping a great hope that it will
look like 60GB (7200!) after enabling transparent compression in reiser4  ;)

Seriously:
Transparent compression and(or) encryption (optionally) in reiser4 are
implemented via cryptcompress object plugin. Whats hot:

- Support of variable cluster size ((1, 2, 4, 8,..) * PAGE_SIZE)
via copy on clustering. The last means that page cluster will be
assembled into united flow before compression, and output stream of
decompression algorithm will be split into pages. Cluster size is an
attribute of cryptcompress files which means a size of maximal chunk
of data that can be passed to compression algorithm. This is required
attribute for each cryptcompress object, each cluster is compressed
and (or) encrypted independently. This allows to apply per cluster
various stream modes for encryption, which are also represented by
reiser4 stream plugins.

- High actual compression ratio which is close to ideal one that can
be provided by the compression algorithm for used cluster size. This is a
property of ctail items (aka fragments) that are used to store data of
cryptcompress objects.

> 
> Current reiser4 benchmarks without it are at
> www.namesys.com/benchmarks.html, and reiser4 is described at www.namesys.com
> 
> Hans
> 
>  >
>  > -------------------------
>  >
>  > From:>  > Michael A Halcrow <mahalcro@us.ibm.com>
>  > Date:
>  > Mon, 26 Jan 2004 11:46:29 -0600
>  > To:
>  > linux-kernel@vger.kernel.org
>  >
>  >
> 
> > I have some time this year to work on an encrypted filesystem for
> > Linux.  I have surveyed various LUG's, tested and reviewed code for
> > currently existing implementations, and have started modifying some
> > of them.  I would like to settle on a single approach on which to
> > focus my efforts, and I am interested in getting feedback from the
> > LKML community as to which approach is the most feasible.
> >
> > This is the feature wish-list that I have compiled, based on personal
> > experience and feedback I have received from other individuals and
> > groups:
> >
> >  - Seamless application to the root filesystem
> >   - Layered over the entire root filesystem
> >   - Unencrypted pass-through mode with minimal overhead

Would you comment this? 

> >   - Files are marked as  ``encrypted'' or ``unencrypted'' and treated
> >     accordingly by the encryption layer

Cryptcompress objects have special file attribute which is an ID of
reiser4 crypto plugin. If this attribute is zero, then file won't be
ciphered. Actually crypto plugin represents a crypto algorithm
supported by reiser4 and includes encrypt(), decrypt() and other
methods specific for this algorithm like setting a pointer of reiser4
specific inode data to cpu key, aligning flow before encryption,
etc.. The same for compression plugins.

> >  - Key->file association
> >   - As opposed to key->blkdev or key->directory granularity

Also cryptcompress file has the following extended attributes (I think
it will be useful to resolve some listed issues):
- digest plugin id (which represents digest algorithm supported by
reiser4: md5, sha1, etc..)
- key id (fingerprint of special randomly generated string, this string
is a part of a secret key, and this 'public' fingerprint is created
by appropriate digest plugin. 'Public' means that all EA should be
stored in disk stat-data. This key id allows to check authorization
every time when file is opened. Authorization is granted only by a
secret key (not by root password)

> >   - No encryption metafiles in directories, instead placing that
> >     information into Extended Attributes
> >   - May break some backup utilities that are not EA-aware; may require
> >     another mode where encryption metadata is stored in a header block
> >     on the encrypted file
> >   - Directories can be flagged as ``encrypted-only'', where any new
> >     files created in that directory are, by default, encrypted, with
> >     the key and permissions defined in the directory's metadata
> >   - Processes may have encryption contexts, whereby any new files they
> >     create are encrypted by default according to the process'
> >     authentication
> >   - Make as much metadata about the file as confidential as possible
> >     (filesize, executable bit, etc.)
> >  - Pluggable encryption (I wouldn't mind using a block cipher in CTR
> >    mode)

Reiser4 allows to support any compression algorithm of Ziv-Lempel
family, and any (symmetric or asymmetric) crypto algorithm (of course,
asymmetric ones are very slowly and may inflate data, but enabling of
short files encrypted by public/private keys can be useful for various
management purposes.

> >  - Authentication via PAM
> >   - pam_usb
> >   - Bluetooth
> >   - Kerberos
> >   - PAM checks for group membership before allowing access to certain
> >     encrypted files
> >  - Rootplug-based LSM to provide key management (necessary to use
> >    LSM?)
> >  - Secret splitting and/or (m,n)-threshold support on the keys
> >  - Signatures on files flagged for auditing in order to detect
> >    attempts to circumvent the encryption layer (via direct
> >    modifications to the files themselves in the underlying filesystem)
> >  - Ad-hoc groups for access to decrypted versions of files
> >   - i.e., launch web browser, drop group membership by default (like
> >     capability inheritance masks) so that the browser does not have
> >     access to decrypted files by default; PAM module checks for group
> >     membership before allowing access (explicit user authorization on
> >     application access requests)
> >  - Userland utilities to support encrypted file management
> >  - Extensions to nautilus and konqueror to be able to use these
> >    utilities from a common interface (think: right-click, encrypted)
> >  - Distro installation integration
> >  - Transparent shredding, where the underlying filesystem supports it
> >  - Versioning and snapshots (CVS-ish behavior)
> >  - Design to work w/ SE Linux
> >
> > These are features that have been requested, but are not necessarily
> > hard requirements for the encrypted filesystem.  They are just
> > suggestions that I have received, and I am not convinced that they are
> >
> > There are several potential approaches to an encrypted filesystem with
> > these features, all with varying degrees of modification to the kernel
> > itself, each with its own set of advantages and disadvantages.
> >
> > Options that I am aware of include:
> >
> >  - NFS-based (CFS, TCFS)
> >   - CFS is mature
> >   - Performance issues
> >   - Violates UNIX semantics w/ hole behavior
> >   - Single-threaded
> >
> >  - Userland filesystem-based (EncFS+FUSE, CryptoFS+LUFS)
> >   - Newer solutions, not as well accepted or tested as CFS
> >   - KDE team is using SSHFS+FUSE
> >
> >  - Loopback (cryptoloop) encrypted block device
> >   - Mature; in the kernel
> >   - Block device granularity; breaks most incremental backup
> >     applications
> >
> >  - LSM-based
> >   - Is this even possible?  Are the hooks that we need there?
> >
> >  - Modifications to VFS (stackable filesystem, like NCryptfs)
> >   - Very low overhead claimed by Erez Zadok
> >   - Full implementation not released
> >   - Key->directory granularity
> >   - Evicts cleartext pages from the cache on process death
> >   - Uses dcache to store attaches
> >   - Other niceties, but it's not released...
> >
> > My goal is to develop an encrypted filesystem ``for the desktop'',
> > where a user can right-click on a file in konqueror or nautilus and
> > check the ``encrypted'' box, and all subsequent accesses by any
> > processes to that file will require authentication in order for the
> > file to be decrypted.  I have already made some modifications to CFS
> > to support this functionality, but I am not sure at this moment
> > whether or not CFS is the best route to go for this.
> >
> > I have had requests to write a kernel module that, when loaded,
> > transparently starts acting as the encryption layer on top of whatever
> > root filesystem is mounted.  For example, an ext3 partition may have
> > encrypted files strewn about, which are accessible only after loading
> > the module (and authenticating, etc.).
> >
> > Any advise or direction that the kernel community could provide would
> > be very much appreciated.
> >
> > Thanks,
> > Mike

Thanks for the list, 
Edward.
