Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTIDOyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbTIDOyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:54:12 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:21778 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265170AbTIDOyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:54:07 -0400
Date: Thu, 4 Sep 2003 16:54:05 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Frederic Gobry <frederic.gobry@smartdata.ch>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 does not detect my touchpad
Message-ID: <20030904165405.A2969@pclin040.win.tue.nl>
References: <20030904115044.GA7114@rhin> <20030904142534.A2949@pclin040.win.tue.nl> <20030904135737.GA7956@rhin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904135737.GA7956@rhin>; from frederic.gobry@smartdata.ch on Thu, Sep 04, 2003 at 03:57:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 03:57:37PM +0200, Frederic Gobry wrote:
> > If you #define DEBUG in i8042.c and make sure you use a large
> > log buffer then all probing is logged via syslog, and we can
> > see what was sent and how the touchpad reacted.
> 
> Here we go:
> 
> kernel: mice: PS/2 mouse device common for all mice
> kernel: i8042.c: 20 -> i8042 (command) [0]
> kernel: i8042.c: 47 <- i8042 (return) [0]

Read controller command byte: 47 - xlate, kie, mie, sysf

> kernel: i8042.c: 60 -> i8042 (command) [0]
> kernel: i8042.c: 56 -> i8042 (parameter) [0]

Write controller command byte: 56 - disable keyboard and kbd interrupt

> kernel: i8042.c: d3 -> i8042 (command) [0]
> kernel: i8042.c: f0 -> i8042 (parameter) [0]
> kernel: i8042.c: 0f <- i8042 (return) [0]
> kernel: i8042.c: d3 -> i8042 (command) [0]
> kernel: i8042.c: 56 -> i8042 (parameter) [0]
> kernel: i8042.c: a9 <- i8042 (return) [0]
> kernel: i8042.c: d3 -> i8042 (command) [0]
> kernel: i8042.c: a4 -> i8042 (parameter) [0]
> kernel: i8042.c: 5b <- i8042 (return) [0]

Write f0, 56, a4 to mouse output buffer and see whether we read
the same values back. (They are given complemented.)
0f, a9, 5b - yes, we do. There was no special magic here.
We conclude that no multiplexer is present.

> kernel: i8042.c: d3 -> i8042 (command) [1]
> kernel: i8042.c: 5a -> i8042 (parameter) [1]
> kernel: i8042.c: a5 <- i8042 (return) [1]

Loop test succeeds.

> kernel: i8042.c: a7 -> i8042 (command) [1]

Disable mouse port.

> kernel: i8042.c: 20 -> i8042 (command) [1]
> kernel: i8042.c: 56 <- i8042 (return) [1]

Check that it really has been disabled. But wait!
The disable bit is 0x20, and it was not set.
We conclude that there is no AUX port.
No PS/2 mouse that can be used.

You can to put #if 0 ... #endif around the four
if statements following the comment

/*
 * Bit assignment test - filters out PS/2 i8042's in AT mode
 */

in i8042.c (since also your mouse was filtered away).

Andries

