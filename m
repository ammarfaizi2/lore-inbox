Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUADILL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 03:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUADILL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 03:11:11 -0500
Received: from mail.mediaways.net ([193.189.224.113]:47754 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S264428AbUADILE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 03:11:04 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Willy Tarreau <willy@w.ods.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
In-Reply-To: <200401041242.47410.kernel@kolivas.org>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401040815.54655.kernel@kolivas.org>
	 <20040103233518.GE3728@alpha.home.local>
	 <200401041242.47410.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1073203762.9851.394.camel@localhost>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 09:09:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 02:42, Con Kolivas wrote:
> On Sun, 4 Jan 2004 10:35, Willy Tarreau wrote:
> > 6) Conclusion
> > =============
> >
> > Under 2.4, xterm uses jump scrolling which it does not use by default under
> > 2.6 if X responds fast enough. The first dirty solution which comes to mind
> > is to renice X to >+10 to slow it a bit so that xterm hits the high water
> > level and jumps.
> >
> > But it's not an effect of the scheduler alone, but a side effect of the
> > scheduler and xterm both trying to automatically adjust their behaviour in
> > a different manner. 
> 
> Not quite. The scheduler retains high priority for X for longer so it's no new 
> dynamic adjustment of any sort, just better cpu usage by X (which is why it's 
> smoother now at nice 0 than previously). 

But why is i.e. running the command a second or third time much faster
compared with the first run ? Does X get less priority then ?

> > If either the scheduler or xterm was a bit smarter or 
> > used different thresholds, the problem would go away. It would also explain
> > why there are people who cannot reproduce it. Perhaps a somewhat faster or
> > slower system makes the problem go away. Honnestly, it's the first time
> > that I notice that my xterms are jump-scrolling, it was so much fluid
> > anyway.
> 
> Very thorough but not a scheduler problem as far as I'm concerned. Can you not 
> disable smooth scrolling and force jump scrolling?

I think it is a schedulers problem as it works if you run the program in
question often enough (dmesg/find/whatever). Suddenly it comes back to
full scrolling speed. 

Judging from the xfree4.3 xterm sources this is the function that gets
called when there is something to scroll. And it looks perfectly ok to
*me* as it scrolls amount lines at once. So the output of (dmesg/...)
seems to be received slower or xterm updates more often than in 2.4.
leading to fewer lines to scroll (== amount). It cannot be xterm
updating more often as it would a) be faster than and b) amount would be
>>> 1 on later on which would lead to high scrolling speed again.

So IMHO it must be the output of the program that is coming in slowly.

I added a fprintf(stderr, "%d\n", amount); to that code and indeed
amount was *always* 1 no matter what I did (it even was 1 when the
(dmesg/...) output came in fast). And jump scrolling would take place if
amount > 59 in my case... can this still be not a schedulers issue ?

from the xfree86-4.3.0 build-tree ./xc/programs/xterm/util.c

/*
 * scrolls the screen by amount lines, erases bottom, doesn't alter
 * cursor position (i.e. cursor moves down amount relative to text).
 * All done within the scrolling region, of course.
 * requires: amount > 0
 */
void
xtermScroll(TScreen * screen, int amount)
{
    int i = screen->bot_marg - screen->top_marg + 1;
    int shift;
    int bot;
    int refreshtop = 0;
    int refreshheight;
    int scrolltop;
    int scrollheight;

    if (screen->cursor_state)
    HideCursor();
    if (amount > i)
    amount = i;
    if (screen->jumpscroll) {
    if (screen->scroll_amt > 0) {
        if (screen->refresh_amt + amount > i)
        FlushScroll(screen);
        screen->scroll_amt += amount;
        screen->refresh_amt += amount;
    } else {
        if (screen->scroll_amt < 0)
        FlushScroll(screen);
        screen->scroll_amt = amount;
        screen->refresh_amt = amount;
    }
    refreshheight = 0;
    } else {
    ScrollSelection(screen, -(amount));
    if (amount == i) {
        ClearScreen(screen);
        return;
    }
    shift = -screen->topline;
    bot = screen->max_row - shift;
    scrollheight = i - amount;
    refreshheight = amount;
[...]

Looking at that how can it not be a scheduling problem ....

Soeren

