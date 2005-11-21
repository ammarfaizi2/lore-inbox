Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVKUUc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVKUUc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKUUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:32:28 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:3206 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932316AbVKUUc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:32:26 -0500
X-ORBL: [69.154.10.203]
Date: Mon, 21 Nov 2005 14:28:25 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: Andrew Morton <akpm@osdl.org>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1
Message-ID: <20051121202825.GA17946@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20051119041130.GA15559@sshock.rn.byu.edu> <20051118221659.64515ac0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118221659.64515ac0.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 10:16:59PM -0800, Andrew Morton wrote:
> If Linux is going to offer a feature like this then people have to
> be able to trust it to be quite secure.  What we don't want to
> happen is to distribute it for six months and then be buried in
> reports of vulnerabilites from cryptography specialists.  Even worse
> if those reports lead to exploits.

I think you brought up two categories of potential security
vulnerabilities. The first has to do with the theoretical security of
the algorithms -- do the encrypted files really have the attribute
such that decrypting the files without the proper key is
computationally infeasible? This is the job for the cryptographers to
confront.

The other category has to do with ``exploits''; I assume you are
talking about -- for instance -- malicious files that are able to
circumvent the intended behavior of the code. Such vulnerabilities may
coerce the filesystem to dump the secret key out to an insecure
location. This is an extension of the general ``correctness'' problem
that can be an issue with any code. I would say that this is the job
of the engineers to help prevent. It basically involves verification
that eCryptfs is handling all of its memory correctly (i.e., via data
and control flow analysis).

> So I guess what I'm asking is: has this code been reviewed by crypto
> experts?  Bearing in mind that it'll be world-class crypto people
> who will try to poke holes in it.

Let's start with the first issue: the theoretical algorithmic security
of eCryptfs. The good news is that there is no new crypto in the
filesystem; we use only existing algorithms. Of course, these
algorithms need to be used correctly in order for them to be of any
use at all (key management typically being the weak point, in my
opinion, which is why the roadmap for eCryptfs incorporates robust
policy-based key management). I give a list of assumptions with regard
to these algorithms further down.

I have thought long and hard about how I am putting it all together
and have presented the design (and my justifications) to several
audiences over the last two years, including crypto researchers, and
nobody has complained (thus far). For those just tuning in, my paper
starts on page 209 of the first half of the OLS 2005 proceedings:

http://www.linuxsymposium.org/2005/linuxsymposium_procv1.pdf

I am actually trying to publicize the code as much as possible at this
point for that exact reason -- so more security and cryptography
experts can analyze our current eCryptfs implementation to criticize
it. I am interested in knowing (a) how well my design holds up and (b)
how well my implementation reflects my design.

The code correctness problem necessitates a significant engineering
effort, given that eCryptfs occupies several thousand lines of new
code. We have been practicing due diligence in having frequent code
reviews over the last year, and we have used various static source
code analysis tools to help out in pinpointing potential problems. We
have a structured internal process of peer review before committing
any changes to the code base. We are making every effort to use our
development resources to ferret out correctness flaws, but community
involvement would help quicken the pace. By submitting our code for
inclusion in the kernel, we are now asking for many eyes to help make
any remaining bugs in eCryptfs shallow.

Keep in mind that eCryptfs is one piece that takes part in confronting
a very large and complex general security problem. Up to this point, I
have been focusing my efforts on the scenario wherein the physical
media is separated from its trusted host environment; my primary goal
is that the sensitive data on the storage media, when separated from
the control of the trusted host, will be unreadable without the proper
key to decrypt it.

There are many other things that should be done to ensure access
control-type security on the trusted host system itself; that sort of
security must be coordinated with the distro's to provide all the
desirable attributes of a comprehensively secure deployment.
Basically, I am stating that, assuming perfect correctness, the
problem of an access control violation on the host causing weakly- or
non-encrypted data to be written to disk, or causing the key to be
compromised, is outside the scope of eCryptfs's specific function,
which focuses on data-at-rest outside the control of the host. It is
the ``assuming perfect correctness'' part that needs verification at
this point. :-)

The express job of eCryptfs is to make sure that if the media is
separated from the trusted host environment, then the confidentiality
of the data on the media is enforced cryptographically. In later
updates to eCryptfs, we will also include integrity verification to
make sure that unauthorized modifications to the underlying data were
not made outside the control of the trusted host. This is easily
accomplished with another standard cryptographic construct; HMAC
values can simply be written side-by-side with IV's on a per-extent
basis.

That said, I am certainly not opposed to exploring how eCryptfs can
coordinate with other access control mechanisms (i.e., SE Linux) to
help prevent access control violations on the host. Another example
that springs to mind, in terms of cooperation with MAC, is an SE
Linux-eCryptfs policy that states, ``Any file object written to
location ABC must be encrypted with crypto context XYZ.''

Now, by way of plugging together existing crypto constructs, I suppose
it is time to state my assumptions:

1) The kernel get_random_bytes() call always provides a random number
   suitable for use as a symmetric Session Key.

2) The symmetric ciphers in the kernel are cryptographically secure
   according to current industry norms and expectations in relation to
   key length (if not, then eCryptfs will need to include a
   ``known good'' cipher list to compare the requested cipher name
   against).

3) It is still the case that the Initialization Vector does not need
   to be secret and that Cipher Block Chaining (CBC) mode is secure,
   when used over 4096-byte chunks of data. The one thing I would like
   feedback on is my IV permutation code; I am wondering if it will be
   necessary to enforce a Feistel network-like property in each
   permutation of the IV as we walk down the extents, or if a simple
   increment (or other naive transformation) of the IV is sufficient
   for each successive extent. Comments?

4) The header file format in RFC2440 (OpenPGP) is secure for the
   purpose of encrypting and storing the encrypted Session Key.

5) Knowledge of the number of bytes in the decrypted version of the
   file is not significantly helpful in cryptanalysis.

6) Users will select cryptographically strong passphrases (note that
   later versions of eCryptfs will use public key and TPM technology).

This list of assumptions will likely grow as eCryptfs undergoes more
scrutiny. Of these assumptions, I would say that assumption 6 is the
weakest; in version 0.1 of eCryptfs, we do allow for a salt to be
specified by the user, but that reduces to basically adding more
characters to the passphrase (we could have hacked it and included a
randomly-generated salt in a mount-associated structure, but that
would violate the per-file crypto context strategy of the filesystem
in general). Future versions of eCryptfs, which will have per-file
passphrase application rather than mount-wide, will use more
intelligent salting to help mitigate the weak passphrase
problem. Ultimately, though, the ``right'' solution is to depend on
more than just a passphrase for protection, and that is part of the
roadmap for eCryptfs.

There are, of course, some things that users could do that might make
their files easier to attack by way of cryptanalysis. Layering
encryption is one such thing (i.e., copying an already encrypted file
with cipher XYZ into an eCryptfs mount point that is using that same
cipher (and key)). This is a general problem w/ all crypto
applications though.

Basically, I am asserting that, as long as my assumptions are valid,
eCryptfs accomplishes its goal of cryptographically enforcing
confidentiality of data at rest on secondary storage. There are plenty
of things that users can (and, unfortunately, will) do to compromise
the cryptographic security afforded by any application, and so that
problem deserves at least as much attention as the cryptographic
properties of the filesystem.

That is one of the reasons why I have been emphasizing making the key
management process as transparent to the user as possible, so that
good practices can be enacted while being as unobtrusive to the user
as possible, so that the crypto is not circumvented or disabled by the
user in frustration (this is likely the biggest security risk in any
crypto app deployment). Once policy support is in place, nothing is
stopping the user from doing something silly like selecting DES with a
key size of 56 bits, and eCryptfs will need to have a way of warning
the user when the security of the filesystem may be in question
(sanity-checking policies against ``best practices'' standards).

That said, there are things that the eCryptfs userspace mount wrapper
could do to help the user out in the version 0.1 release, like do a
standard weak-passphrase check against the passphrase given to the
mount wrapper (actually, now that I think about it, I see no reason
why the eCryptfs mount wrapper could not use PAM). My recommendation
right now is that the user generate a cryptographically random string
of printable bytes for the passphrase, having a sufficient length so
as to be, given the base of valid passphrase characters, sufficient in
size given the keyspace for the cipher being used. In other words, the
problem of brute-forcing the Session Key and brute-forcing the
passphrase should be computationally equivalent.

In later versions of eCryptfs, there will be public key and TPM
support. Then, once policy support is in place and eCryptfs is being
shipped as part of the distro (making proper use of a TPM), the whole
package will be even more secure and transparent to the user
experience. One step at a time, though. I would like to get the kinks
worked out of the basic passphrase-based modes of operation
(especially correct and stable VFS-related operation) before adding
more complexity to eCryptfs.

Thanks,
Mike
