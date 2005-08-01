Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVHAXFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVHAXFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVHAXFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:05:07 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11410 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261313AbVHAXEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:04:02 -0400
Date: Mon, 1 Aug 2005 16:03:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050801160351.71ee630a.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508011147030.5541@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
	<20050729230026.1aa27e14.pj@sgi.com>
	<Pine.LNX.4.62.0507301042420.26355@graphe.net>
	<20050730181418.65caed1f.pj@sgi.com>
	<Pine.LNX.4.62.0507301814540.31359@graphe.net>
	<20050730190126.6bec9186.pj@sgi.com>
	<Pine.LNX.4.62.0507301904420.31882@graphe.net>
	<20050730191228.15b71533.pj@sgi.com>
	<Pine.LNX.4.62.0508011147030.5541@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok - its definitely getting shorter and sweeter.  Good.

There are quite a few small magic numbers - is there someway to code
these out?  See also my comment below, mentioning kernel/power/main.c.
Changing one of the strings should not break the code until the
corresponding magic string length numbers are changed to match.

+               p += 7;
+               if (e < p + 8 /* fixed string size */ + 4 /* max len of node number */)
+               if (e < p + 8)
+               if (e < p + 14)
+       if (strnicmp(buffer, "default", 7) == 0)
+       if (strnicmp(buffer, "prefer=", 7) == 0) {
+               node = simple_strtoul(buffer + 7, NULL, 10);
+       } else if (strnicmp(buffer, "interleave=", 11) == 0) {
+               if (nodelist_parse(buffer + 11, nodes) ||
+       } else if (strnicmp(buffer, "bind=", 5) == 0) {
+               if (nodelist_parse(buffer+5, nodes))

And the code should not break, silently overwriting kernel stack, if
and when someone tries this on a 10,000 node system (the '4' max len of
node number).  There are snprintf style routines to avoid such risks.

I'd be tempted to code for just lower case matches, not case
insensitive, which seems like gratuitous flexibility to me.

The existing numa code has a routine get_nodes(), in mm/mempolicy.c,
that obtains the nodelist from the arguments to the mbind or
set_mempolicy system call, and does a fair bit of checking on the
nodelist, in the context of the current task (the task whose mempolicy
is to be changed).  Only after this checking can the resulting policy
and nodelist be applied.  In the other parts of your intended changes,
where you expect to use the results of this code to convert a string
to a numa policy, where to you expect to duplicate the portion
of get_nodes() that checks the nodelist and policy, in the target
tasks context?  This might involve refactoring get_nodes() into two
routines - one to obtain a nodemask_t representation of the nodelist
passed in via the set_mempolicy/mbind system calls, and the other to
perform the checking.

In your related patch, you show how to merge this display of mempolicy
into the new /proc/<pid>/smap (rss size of each memory area) file.
But this smap file (or, as you renamed it, emap file) is read-only,
so far as I can tell.  It enables display of information, but not
changing it.  How do you propose to support changing a memory policy?
How will the other half of this patch, that converts strings to
memory policies, be used?  If I knew that (you've probably said,
and I've probably forgotten - sorry) then I might then ask whether
that other half should not also be used to display memory policies,
instead of adapting smap aka emap.

There is an alternative representation of this information which
I have in mind, but cannot yet evaluate the usefulness of, due to
the above aspects that I don't understand yet.  Instead of one file
(or one line in a file) having one of the following formats:

    default
    preferred=<nodenumber>
    bind=<nodelist>
    interleave=<nodelist>

Would it be better to have two files, the first of which has one of
the strings:

    default
    preferred
    bind
    interleave

and the second of which has a nodelist, the significance of which
depends on the policy specified in the first.  These files might be
called "numa_policy" and "numa_nodelist", or some such.  Perhaps they
would be both read and write (display and parse), which would remove
the need for a separate read-only display in the smap/emap file.
Since I am still missing some "big picture" stuff here, I don't know
if this option is worth considering or not.  But it would honor the
ideal of a single token, number or list of numbers per file.

Consider as an example the display and parsing of pm_states by the
state_show() and state_store() routines of kernel/power/main.c, for
ways to code this that separate the data (list of strings parsed
and the mapping between constants and strings) from the code logic,
and that use strlen() to avoid magic length numbers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
