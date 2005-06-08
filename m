Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVFHQFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFHQFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVFHQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:01:39 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:54949 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261340AbVFHP4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:56:38 -0400
Message-ID: <003301c56c4a$089f3b40$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: Q: console_macros.h
Date: Wed, 8 Jun 2005 12:49:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#define vc_state ....

This particular macro happens to be the SAME NAME as the vconsole data
structure member it references.

This seems quite unhandy if you try to reference the vc_state member using a
pointer to a vconsole data structure like so:

struct vc_data *vcdp = vc_cons[currcons].d;

vcdp->vc_state = whatever...;

The macro will expand (because of course it has the same name and the
preprocessor doesn't know the difference) when what you really wanted was
the structure member.  Cryptic syntax errors result.

So... HERE IS THE QUESTION: was there some compelling reason this particular
macro should be this way, (rather than #define state ...) or was it just
some ages old typo that was never noticed?

Of course, if all you use is the macros to reference vconsole data, the
issue never surfaces - but the resultant code quality suffers when some
function has several macros in it that could benefit from caching a pointer
to the current vcon structure and using that.

Caching console data pointers rather than using the macros everywhere in a
prototype I've been working up has provided a fairly dramatic reduction in
the amount of code and it will run a lot faster as well with fewer
indirections to follow.  With the macros, on an x86 build I was seeing
sequences of several LEA instructions all over the place for the multiple
indirections.

