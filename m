Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131099AbQKRCOd>; Fri, 17 Nov 2000 21:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQKRCOZ>; Fri, 17 Nov 2000 21:14:25 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:6664 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131099AbQKRCOR>; Fri, 17 Nov 2000 21:14:17 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.GSO.4.21.0011161843430.13047-100000@weyl.math.psu.edu>
X-Emacs: or perhaps you'd prefer Russian Roulette, after all?
From: Nix <nix@esperi.demon.co.uk>
Date: 18 Nov 2000 01:30:50 +0000
In-Reply-To: Alexander Viro's message of "17 Nov 2000 10:21:05 -0000"
Message-ID: <87k8a23w39.fsf@loki.wkstn.nix>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> If every way from foo to target goes through the source rename(source,target)
> _will_ make the graph disconnected. Checking that for generic DAG is a hell.

Why do you say this? Algorithms for cycle detection are comparatively
computationally expensive, to be sure, but they are well understood. In
fact, this is only a limited case of cycle detection; unless I
misunderstand, it's a form of dominator detection, as seen, for
instance, in compilers. You're looking to see if the source dominates
the target, and if it does, you scream.

It needn't be hellish, *if* we can get a list of all a directory's
parents given that directory in reasonable time, and that depends on how
multiple-parents is implemented. Checking if the source dominates the
target (for paths from the root) wouldn't be anywhere near so bad
then. See below for an algorithm to try out --- well, for its name. I
have a good few references to relevant papers too (so too will anyone
with much to do with compiler hacking.)

> Moreover, if there is an oriented path from source to target rename(source,
> target) will create a loop. Again, good luck checking whether there is
> such a path.

Loops and what they do to things like ftw() --- and thus to the
expectations of userspace programs --- are I think the *real* reason why
no Unix has ever implemented this. There are probably a good few
programs that depend on ftw() and friends descending into all
directories that you asked them to, and then there's all those recursive
tree traversers in userspace that *don't* use ftw().

Certainly all cycles must be banned. Luckily the cycles aren't that
nasty to detect. You can detect cycles with the same algorithm you use
to detect the rename(source,target) case; if the source dominates the
target you can't have a link to the source in the target, as that would
make a cycle. (I may be missing some cases that make cycle detection
harder than this; it's late and I'm drunk and tired, and it's been years
since I paid much attention to anything much to do with cycle
detection.)

>              If you think that loops are not a problem - fine, their presense
> will make checking the first condition (for every node foo there exists a
> path foo,p1,...,pn,target such that source doesn't belong to {p1,...,pn})
> _much_ funnier.

It's userspace that this kills; the kernel can be fixed, but fixing the
entirety of userspace isn't going to happen :)

> For trees both conditions turn into (source is not an ancestor of target)
> and that's easy to check. Try to do that for generic DAG. Solutions that
> cost O(graph size) are _not_ acceptable - graph is the whole directory
> structure.

There are well-understood algorithms for computing dominators that do
not cost that much. The Lengauer-Tarjan algorithm takes O(n ln n) time,
where n is the depth of the graph (== the depth of the deepest path to
get to the target). However it is rather heavy-duty for a kernel, and I
rather doubt that any kernels use it :)

The O(graph size) solutions are deeply crap ways of computing
dominators; they normally start by sweeping over the whole graph working
out who dominates who from the top down. Algorithms like that were
obsolete by the late seventies!

Lengauer-Tarjan works from the bottom up; as long as you can do that,
you're home free. (Well, not free; O(n ln n.) ;} )

Ancient paper reference (there are probably newer papers than this):

Lengauer, T., & Tarjan, R. E., _A fast algorithm for finding dominators
in a flow graph_, 1979, _Transactions on Programming Languages and
Systems_ 13(4): 451--490.

(Somewhere, I have a copy of this paper. Cthulhu alone knows where
though.)


(Disclaimer: I've never tried to use Lengauer-Tarjan in filesystem code;
it just seems likely to me that it or some variant of it would work
there, except of course that it is a somewhat overblown algorithm to
find in a kernel. :) )

-- 
`The phrase `causes storage to be reserved', doesn't mean that it causes
 storage to be reserved.  This is a fundamental misunderstanding of
 Standardeze.' --- Mike Stump on the GCC list
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
