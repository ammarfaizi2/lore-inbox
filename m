Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUGBB06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUGBB06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUGBB06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:26:58 -0400
Received: from main.gmane.org ([80.91.224.249]:23227 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265953AbUGBB0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:26:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@entermail.net>
Subject: Re: [PATCH] task name handling in proc fs
Date: Thu, 01 Jul 2004 21:27:32 -0400
Message-ID: <cc2dkn$e63$1@sea.gmane.org>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com> <20040701151935.1f61793c.akpm@osdl.org> <20040701224215.GC5090@w-mikek2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: poctnt-1-261.dialup.enter.net
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:

> On Thu, Jul 01, 2004 at 03:19:35PM -0700, Andrew Morton wrote:
>> Mike Kravetz <kravetz@us.ibm.com> wrote:
>> >
>> > --- linux-2.6.7/fs/proc/array.c    Wed Jun 16 05:19:36 2004
>> > +++ linux-2.6.7.ptest/fs/proc/array.c      Thu Jul  1 17:44:14 2004
>> > @@ -97,14 +97,14 @@
>> >  name++;
>> >  i--;
>> >  *buf = c;
>> > -          if (!c)
>> > +          if (!*buf)
>> >  break;
>> > -          if (c == '\\') {
>> > -                  buf[1] = c;
>> > +          if (*buf == '\\') {
>> > +                  buf[1] = *buf;
>> >  buf += 2;
>> >  continue;
>> >  }
>> > -          if (c == '\n') {
>> > +          if (*buf == '\n') {
>> >  buf[0] = '\\';
>> >  buf[1] = 'n';
>> >  buf += 2;
>> 
>> What is this code for?
> 
> The code is copying the task name from 'c' to 'buf' one character
> at a time.  It is then 'post processing' the characters.  Currently,
> the post processing is based on the value of c which is part of the
> source string (task->curr).  However, it is possible for the source
> string to change during this copy (think exec).

Except that c is not "part of the source string". The code "c =
*name" (where name starts off pointing to the same place as p->comm) is
executed once and only once per time through the loop. Then it does "*buf =
c". Your change would protect not against a change in "name" (which is
possible), but against a change in "buf" while we're writing to it
(impossible, as long as I'm understanding the proc code correctly).

Not that there is no race here, but that doesn't fix it. What's needed is
either another strcpy or locking around p->comm as suggested by Andrew
Morton.

--Andrew Rodland < arodland@entermail.net > via GMANE

