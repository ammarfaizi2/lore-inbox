Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753206AbWKCOIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbWKCOIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbWKCOIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:08:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:53274 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753206AbWKCOIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:08:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwUM3XJoXX4hQKHTOiixaITg1pjKmADE2ggCbUteHhiavnzrlNbllLM8ohxJ7MIgQ87ivmhsKUvR/1H+U0P97KZUY4UARU3T2/Gvdg0odi6Elr5SATCK9s+MEJdgLSH2kcctIaMgY/bRl1DMDi+N5XBN/o6MaGJ8C457RoRGhk4=
Message-ID: <d120d5000611030608v726b5459y743703179d079ae5@mail.gmail.com>
Date: Fri, 3 Nov 2006 09:08:47 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: "Dave Neuer" <mr.fred.smoothie@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061103081847.GC10906@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610300501w240a8ce1h4d58b1f3f2f759bf@mail.gmail.com>
	 <161717d50610300622h15d5e40w4a30e1a95b3c2564@mail.gmail.com>
	 <200611030056.03357.dtor@insightbb.com>
	 <20061103081847.GC10906@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Nov 03, 2006 at 12:56:02AM -0500, Dmitry Torokhov wrote:
> > On Monday 30 October 2006 09:22, Dave Neuer wrote:
> > > On 10/30/06, Dave Neuer <mr.fred.smoothie@pobox.com> wrote:
> > > >
> > > > Maybe I'm missing something, (well actually I'm sure I'm missing
> > > > somethng). Looking at the code again, it's unclear to me why there is
> > > > even a call to the ISR in i8042_aux_write, since the latter function
> > > > already calls i8042_read_data.
> > > >
> > >
> > > Whoops, sorry. I meant i8042_command, which is called by
> > > i8042_aux_write before the call to i8042_interrupt, already calls
> > > i8042_read_data.
> > >
> >
> > It only calls i8042_read_data() if command is supposed to return data.
> > Neither I8042_CMD_AUX_SEND nor I8042_CMD_MUX_SEND wait fotr data to come
> > back.
> >
> > Anyway, I removed call to i8042_interrupt() from i8042_aux_write() because
> > it is indeed unnecessary.
>
> It was there because some older i8042's will report an error byte (=>
> data) even though no device is connected, not just set error flags.
>
> The unflushed byte in the FIFO then caused problems later on.
>
> It may be that now it'll get disposed of correctly, I haven't looked at
> the code for a while.
>

By the time serio ports are registered and there are potential users
of i8042_aux_write() we already requested AUX IRQ and I believe any
arriving data should be automatically disposed through irq handler. It
wasn't the case before, when we postponed requesting IRQ until the
port was opened...

-- 
Dmitry
