Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUG1Lwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUG1Lwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUG1Lwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:52:34 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:35592 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266887AbUG1Lwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:52:30 -0400
Date: Wed, 28 Jul 2004 13:51:30 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040728115130.GA4008@pclin040.win.tue.nl>
References: <87llhjlxjk.fsf@devron.myhome.or.jp> <20040716164435.GA8078@ucw.cz> <20040716201523.GC5518@pclin040.win.tue.nl> <871xjbkv8g.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xjbkv8g.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 03:23:27PM +0900, OGAWA Hirofumi wrote:

> > :: KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
> > :: key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
> > :: 
> > :: 	key_map[0] = U(K_ALLOCATED);
> > :: 	for (j = 1; j < NR_KEYS; j++)
> > :: 		key_map[j] = U(K_HOLE);
> > 
> > I think the code has no opinion. It was 128 in 2.4.
> > I am not aware of assumptions on NR_KEYS.
> > So, do not think this is an off-by-one error.
> 
> My point is that key_map is 0-254 array. But KDGKBENT uses 255
> 
> 	case KDGKBENT:
> 		key_map = key_maps[s];
> 		if (key_map) {
> 		    val = U(key_map[i]);

Hmm. Yes.

In 2.4 the preceding code is

        if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
                return -EINVAL;

It looks like somebody removed this test in 2.6. Bad.
No doubt an error caused by "fixing" gcc warnings.
Shame on akpm.

When an array has an arbitrary upper bound that can be changed
via a #define, and for some values of the upper bound a test
is superfluous, that does not mean that the test is superfluous.

Andries

