Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUJGPJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUJGPJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUJGPJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:09:20 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:33196 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S267298AbUJGPCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:02:25 -0400
Date: Thu, 7 Oct 2004 11:01:55 -0400
From: Jean-Sebastien Trottier <jst1@email.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041007150155.GA2704@mc>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <Pine.LNX.4.61.0410071432070.304@hibernia.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410071432070.304@hibernia.jakma.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an outsider's view of someone that has been following this thread:

Could select() have 2 different behaviors depending on wether the
O_NONBLOCK flag is set or not on the socket.

1. If O_NONBLOCK is set, it can immediately return that the socket is
ready to be read (while CRC and possibly other checks are being done in
background). A subsequent call to recvfrom may return EWOULDBLOCK if in
the mean time the data was discarded by the kernel. This is current
behavior.

An application using O_NONBLOCK should be ready to deal with
consequences.

2. In the case where O_NONBLOCK is not set, select() could wait for all
the checks to be done before deciding to return or not. In this case the
meaning would be "there is data ready", NOT "there *might* be data
ready".

This way, there should not be any performance hits for (IMHO) well built
applications that use O_NONBLOCK. And the POSIX standard would not be
broken otherwise and applications that don't use O_NONBLOCK can rely on
actual data being read in recvfrom.

Just my 2 cents...
Sebastien

On Thu, Oct 07, 2004 at 02:36:26PM +0100, Paul Jakma wrote:
> On Thu, 7 Oct 2004, Martijn Sipkema wrote:
> 
> >Any sane application would be written for the POSIX API as 
> >described in the standard, and a sane kernel should IMHO implement 
> >that standard whenever possible.
> 
> NB: I dont disagree with you.
> 
> Just the impression I get is that there is no way to avoid this 
> situation without a serious performance impact, and that the 
> optimisation shouldnt really any affect any healthy app. (any which 
> are really should be setting O_NONBLOCK).
> 
> If you could follow the spec without significantly harming 
> performance, then I'd agree spec should be followed.
> 
> I dont really have anything useful to say other than that, IMHO, a 
> sane app should be using O_NONBLOCK if it really does not want to 
> block, so I shall now quietly back away from this thread.
> 
> regards,
> -- 
> Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
> Fortune:
> What this country needs is a good five cent microcomputer.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
