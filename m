Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282600AbRK0TDf>; Tue, 27 Nov 2001 14:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282625AbRK0TD0>; Tue, 27 Nov 2001 14:03:26 -0500
Received: from sj1-3-1-20.iserver.com ([128.121.122.117]:16394 "EHLO
	sj1-3-1-20.iserver.com") by vger.kernel.org with ESMTP
	id <S282600AbRK0TDT>; Tue, 27 Nov 2001 14:03:19 -0500
Date: Tue, 27 Nov 2001 19:03:18 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: linux-kernel@vger.kernel.org
Cc: vda@port.imtp.ilyichevsk.odessa.ua, alan@redhat.com,
        torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011127190318.A91208@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua,
	alan@redhat.com, torvalds@transmeta.com, marcelo@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote in http://marc.theaimsgroup.com/?l=linux-kernel&m=100687040003540&w=2:
> On Monday 26 November 2001 18:28, Alan Cox wrote:
> > > > MODINC(x,y) (x = (x % y) + 1)
> > >
> > > drivers/message/i2o/i2o_config.c:#define MODINC(x,y) (x = x++ % y)
> > >
> > > Alan, can you clarify what this macro is doing?
> > > What about making it less confusing?
> >
> > Nothing to do with me 8). I didnt write that bit of the i2o code. I agree
> > its both confusing and buggy. Send a fix ?
> 
> This is a test to be sure my replacement is equivalent:
> --------------------
> #include <stdio.h>
> #define MODINC(x,y) (x = x++ % y)
> #define MODULO_INC(x,y) ((x) = ((x)%(y))+1)
> ...

If they really are equivalent, you have certainly found a bug.

Examining the code in i2o_config.c, it is expected that the q_in argument 
ranges from 0 to I2O_EVT_Q_LEN-1, but the result of MODINC can never 
be 0, and may equal I2O_EVT_Q_LEN, overindexing the array member 
event_q and clobbering all the remaining members (including q_in).

The correct fix appears to be 

  #define MODULO_INC(x,y) ((x) = ((x)+1)%(y))

Nathan Myers
ncm at cantrip dot org
