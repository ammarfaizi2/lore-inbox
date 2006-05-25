Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWEYDKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWEYDKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWEYDKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:10:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4739 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964817AbWEYDKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:10:14 -0400
Date: Thu, 25 May 2006 04:10:12 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [RFC] log comparison, build regressions and remapping
Message-ID: <20060525031012.GO27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There is an annoying problem that makes watching for build
regressions painful and frustrating.  One would've thought that
it ought to be a simple matter of diff between the build logs - that
should show what had changed.  Of course, a sentence with such beginning
can only be followed by equivalent of "and I have a nice bridge for you".

	The source of problem is quite simple: warnings, errors, etc. refer
to locations in the source.  And if you do something as simple and innocious
as adding #include, editing a comment or adding a couple of lines in unrelated
function, you suddenly get
foo/obscure/junk.c:53: warning: unused variable 'psJustInCase'
replaced with
foo/obscure/junk.c:54: warning: unused variable 'psJustInCase'
et sodding cetera.  Of course, it _is_ the same warning, refering to the
exact same line of code.  The only thing that has changed is the line number.
Of course, that is enough for diff(1).

	That might sound like a minor annoyance.  Yes, you could end up with
some noise in the diff, but surely it will be easy to recognize and ignore.
And I have a nice bridge for you, again.  In reality that is far from being
a minor annoyance.  If you do such comparison of build (or sparse) logs on
kernel source, two months worth of changes will be more than enough to drown
all real information in the noise.

	Of course, the root cause is that we are comparing apples with
oranges - references to locations in the old tree with references to
locations in the new one.  To get a meaningful comparison we must know
where the lines of old tree have gone in the new one.  In other words,
we need to build a map and then use it to filter logs into comparable
form.  I have finally grown sick and tired of the noise to do just that;
it turned out to be easy enough.

	Results are on ftp.kernel.org/pub/linux/kernel/people/viro/remapper/
There are two scripts that generate maps (from a couple of trees and from
a couple of revisions in git archive resp.) and a filter using those maps.

	To generate a map:
diff-remap-data <old-tree> <new-tree>  > map
or
git-remap-data <usual git diff arguments>  > map

	To filter:
remap-log <map> -p <original prefix> -o <old-only prefix> -n <new prefix>

That will transform lines of form
<original prefix><filename>:<line number>:<text>
either to
<old-only prefix><filename>:<line number>:<text>
or to
<new prefix><new filename>:<new line number>:<text>
depending on the fate of location in question - the first form is used if
location doesn't make it into the new tree and the second one (with remapped
line number and filename) is used if the counterpart in the new tree does
exist.

You don't have to supply all prefices.  Defaults are:
	* empty string for original prefix and new prefix
	* O: for old-only prefix

In practice you only need to change those if you are chaining the remappers,
e.g. remap-log map12 -o died_early: | remap-log map23 -o died: -n lives:
etc.

	Have fun.  I've used it with very nice noise reduction on kernel
build and sparse logs; it can be used for any userland builds as well
and I'd love to hear about the results.  Comments, suggestions, bug reports,
etc. are welcome.
