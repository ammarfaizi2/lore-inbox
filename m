Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270232AbRHGXxf>; Tue, 7 Aug 2001 19:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270231AbRHGXxZ>; Tue, 7 Aug 2001 19:53:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36229 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S270229AbRHGXxN>;
	Tue, 7 Aug 2001 19:53:13 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 7 Aug 2001 23:52:49 GMT
Message-Id: <200108072352.XAA25661@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [RFC][PATCH] parser for mount options
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it breeds global variables for no good reason

Globals? What globals?

> Switch that will keep growing, BTW.
> would turn into complete mess two years down the road.

But this was written five and a half years ago, and I think it
still suffices.

> There are two different tasks - one of them is to decide which option we
> are dealing with and another - decode and act upon it.  Mixing parsing
> and data conversion in that kind of situations is a Bad Thing(tm).

Possibly. I like the option parsing for each filesystem:

	parse_mount_options((char *) data, SIZE(opts), opts);

and this does parse_and_assign. You do

	while (more_tokens) {
		t = type_of_next_token();
		switch (t) {
		case ...
		}
	}

where the type_of_next_token() does the parsing, and the switch
does the assigning. Much more code. Much uglier - but tastes differ.
The reason that I call it uglier is that you have the same, or
nearly the same code for each filesystem. But then discrepancies arise,
and things are not treated uniformly across filesystems. A single
parser and assigner forces uniformity.
You have a coherency problem. In

+enum { Opt_mode, ...};
+                               
+static match_table_t tokens = {
+       {Opt_mode, "mode=%o"},
...
+                       case Opt_mode:
+                               mode = match_octal(args);
+                               break;

the %o must correspond to the match_octal().
But that is unfortunate duplication.
That same code is

	{ "mode", OPT_INT_8, 0, &mode},

for me. Not only much more compact, but no coherency problem either.
Of course one might write

	{ "mode", "%o", 0, &mode},

to save the reader the trouble of looking up what OPT_INT_8 means.

If you see strange warts in my parser it is mostly because
it was a patch without user-visible changes, so all existing
msdos option peculiarities had to be accommodated.
Once such code is in place one needs a very good reason to
invent option syntax not covered by it.

Andries
