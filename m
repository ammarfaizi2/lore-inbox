Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRBWMWy>; Fri, 23 Feb 2001 07:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129600AbRBWMWo>; Fri, 23 Feb 2001 07:22:44 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:8330 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S129729AbRBWMWd>;
	Fri, 23 Feb 2001 07:22:33 -0500
Message-Id: <l03130300b6bbd7483cd3@[192.168.239.101]>
In-Reply-To: <UTC200102230249.DAA252851.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 23 Feb 2001 12:20:54 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Now that you provide source for r5 and dx_hack_hash, let me feed my
>collections to them.
>r5: catastrophic
>dx_hack_hash: not bad, but the linear hash is better.

<snip verbose results>

So, not only does the linear hash normally provide a shorter worst-case
chain, its' results are actually more consistent than the other two.  Looks
like simple is good here, but is it still possible to produce
"pathological" sets for the linear hash to see how badly it falls down?
I'm no mathematician, so I'll leave that to the gurus...

Meanwhile, let's go back to Linus' comment on compatibility and so on.  He
has a *very* good point, which I'll expand on slightly here:

Suppose some stone-age Linux user, running 2.0.35 or something equally old
(which runs ext2), decides to finally bite the bullet and upgrade to the
all-new 2.6.1 (OK, this is some time in the future).  2.6.1 implements some
"enhanced" version of ext2 which makes some incompatible modifications to
the directory structure.  However, since the process of upgrading through
such a massive range of kernels also involves upgrading most other software
to boot, this user forgot one or two pieces, and reboots to 2.0.35 to
regain a sufficiently working system that he can build the updated software
- or not, because 2.0.35's old ext2 code suddenly can't read the
filesystem, which was modified by 2.6.1 before the boot process stalled.
e2fsck is no help here either, because he now has an unbootable system with
old software that doesn't understand the new stuff.

I hope people understand this as well as I do - if a filesystem upgrade is
desirable, let the user perform some *specific* action to upgrade it, when
he has an otherwise-working setup *and* sufficient backups.  I for one do
not want to be caught out like the hypothetical user I mentioned above.

OTOH, I have my own opinions on the direction of ext2:

- Currently, it's a stable and universally-utilised filesystem which offers
very good performance for most applications.  I'm specifically drawing
attention to certain benchmarks which place ext2's disk-based performance
ahead of many commercial UNIX' ram-based filesystem performance.

- There are specific problems with performance when reading and/or
modifying large directories.  I haven't tested for this personally, but I
have noticed slowness when using 'rm -rf' on a large *tree* of directories.
The problem appeared to be one of disk access, but may be a side-effect of
poor storage distribution (I haven't examined the ext2 code).  Related to
this, rebuilding the slocate database on all my systems appears to be
disk-bound rather than CPU-bound, and takes too long for my liking.

One of the current suggestions, if I've interpreted it correctly, is to
introduce an extension to ext2 which essentially makes a "fast index" of a
large directory, attaches it to the directory in some backwards-compatible
manner, and uses it *in conjunction with* the regular directory structure.
This is probably a good idea, but it needs some thought:

- How much overhead does the "fast index" introduce for modification of the
directory?  Large directories are the most likely to have stuff added and
deleted, and it doesn't help if during an "rm *" operation the saving on
the search is negated by the overhead on the unlink.

- If the index gets out of sync with the directory, how is this detected
and recovered from?  Assuming the index merely points to the correct
position in the regular directory, some simple sanity checks will suffice
for most cases (is this entry in the directory the same as I asked for?),
and if the entry is not in the index then a standard search of the real
directory can be done.  In either case, the index can be marked as invalid
(and removed?) and rebuilt whenever necessary.

- At what threshold of directory size does the index come into play?
(fairly obviously, the index is useless for tiny directories)

- What happens when an old kernel encounters a directory which has an index
attached to it?  Does it look like a virtual file, which has no special
properties but whose name is reserved for system use?  (cf. lost+found)  Or
is it some inidentifiable bits in the directory structure and a few lost
clusters on the disk?  If the latter, it will have to be done in a way that
older versions of e2fsck can clean it up easily and older versions of ext2
won't throw up on it, which could be kinda hard.  If the former, an
'unused' name will have to be found to avoid conflicts but the big
advantage is *no* inconsistency with old systems.

Answers on a postcard...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


