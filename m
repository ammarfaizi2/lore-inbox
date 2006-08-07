Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWHGSUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWHGSUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHGSUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:20:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:48822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932275AbWHGSUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:20:44 -0400
X-Authenticated: #5039886
Date: Mon, 7 Aug 2006 20:20:47 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060807182047.GC26224@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Shem Multinymous <multinymous@gmail.com>,
	Pavel Machek <pavel@suse.cz>, Robert Love <rlove@rlove.org>,
	Jean Delvare <khali@linux-fr.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	hdaps-devel@lists.sourceforge.net
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.07 19:30:55 +0300, Shem Multinymous wrote:
> Hi Pavel,
> 
> On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> >> +     int total, ret;
> >> +     for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
> >
> >Could we go from 0 to timeout, not the other way around?
> 
> Sure.
> (That's actually vanilla hdapsd code, moved around...)

Maybe you could convert that to sth. like this along the way?

int ret;
unsigned long timeout = jiffies + msec_to_jiffies(READ_TIMEOUT_MSECS);
for (;;) {
	ret = thinkpad_ec_lock();
	if (ret)
		return ret;
	ret = __hdaps_update(0);
	thinkpad_ec_unlock();

	if (ret != -EBUSY)
		return ret;
	if (time_after(timeout, jiffies))
		break;
	msleep(RETRY_MSECS);
}
return ret;

Rationale: http://lkml.org/lkml/2005/7/14/133 - it's also listed on the
kerneljanitors todo list.

Regards
Björn
