Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVG3Bfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVG3Bfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVG3Bfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:35:33 -0400
Received: from mx1.rowland.org ([192.131.102.7]:26897 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S262899AbVG3BfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:35:01 -0400
Date: Fri, 29 Jul 2005 21:35:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of
 pages in PBE list
In-Reply-To: <42EA9C38.90905@stud.feec.vutbr.cz>
Message-ID: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Michal Schmidt wrote:

> Rafael J. Wysocki wrote:
> > On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> > 
> >>The function calc_nr uses an iterative algorithm to calculate the number 
> >>of pages needed for the image and the pagedir. Exactly the same result 
> >>can be obtained with a one-line expression.
> > 
> > 
> > Could you please post the proof?
> > 
> > Rafael
> 
> OK, attached is a proof-by-brute-force program. It compares the results 
> of the original function and the simplified one.

Here's a more general proof.

As I understand it, calc_nr is given nr_copy, the number of data pages
that need to be written out, and it has to return the number of pages
needed to hold the image data plus a bunch of PBE pagedir indexes, where
each page gets one index (and pages containing PBEs need their own indexes
as well).

For brevity, let n = nr_copy, let p = PBES_PER_PAGE, and let x be the 
number of pagdir pages needed.  Since each page can hold p PBEs, there 
will be room to store px PBEs.  The total number of pages is n + x, so 
the routine needs to find the smallest value of x for which

	px >= n + x

or

	(p-1)x >= n

or

	x >= n / (p-1).

The obvious solution is

	x = ceiling(n / (p-1)),

so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
Michal's patch computes.

Alan Stern

