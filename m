Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTASEGJ>; Sat, 18 Jan 2003 23:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTASEGJ>; Sat, 18 Jan 2003 23:06:09 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:58773 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265382AbTASEGI>; Sat, 18 Jan 2003 23:06:08 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 18 Jan 2003 20:14:39 -0800
Message-Id: <200301190414.UAA10226@adam.yggdrasil.com>
To: vandrove@vc.cvut.cz
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable
Cc: akpm@digeo.com, alsa-devel@alsa-project.org, harinath@cs.umn.edu,
       linux-kernel@vger.kernel.org, perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In original message I asked whether I should convert firmware loader to 
>the "if (error) goto quit;" style to move error handling to one place, 
>but only answer I got was 'Ask Rob' ;-)

	To my knowledge, a goto in this case is not necessary for
avoiding code duplication.  If there are a small number of failable
steps that may need to be unwound, you could adopt the style of my patch
(which shortened the code slightly):

       if (step1() == ok) {
		if (step2() == ok) {
			if (strep3() == ok)
				return OK;
			undo_step2();
		}
		undo_step1();
	}
	return failure;

	If the nesting gets any deeper than this, then a more
understandable solution for readability than using goto would be to
define a separate inline routine.

	In general, I recommend using goto only when it is
topologically necessary to avoid code duplication or due to some
compiler quirk where you want to sqeeze a few more cycles out of code
in a critical path.  That way, the use of goto basically flags these
unusual cases for other programmers.

	Examples of cases where a goto really is needed to avoid code
duplication include a switch() or a group of if() branches need to
flow back together after starting out by doing different things, and
where you want to break from an outer loop and for some reason don't
want to write the outer loop as an inline routine (for example, you
also have a "return" statement for the existing subroutine in this
loop).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
