Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSFRD2L>; Mon, 17 Jun 2002 23:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317301AbSFRD2J>; Mon, 17 Jun 2002 23:28:09 -0400
Received: from [159.226.39.4] ([159.226.39.4]:7054 "HELO mail.ict.ac.cn")
	by vger.kernel.org with SMTP id <S317300AbSFRD2A>;
	Mon, 17 Jun 2002 23:28:00 -0400
Message-ID: <3D0EA83A.50606@ict.ac.cn>
Date: Tue, 18 Jun 2002 11:25:46 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: Robert Olsson <Robert.Olsson@data.slu.se>
CC: Paul <xerox@foonet.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: NAPI eepro100 bug fixed
References: <15624.57000.928651.530593@robur.slu.se>	<JBEKKKICLLIJKLIGCCKLCEAJCCAA.xerox@foonet.net> <15624.63280.379421.369909@robur.slu.se>
Content-Type: multipart/mixed;
 boundary="------------080207080103070507080101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080207080103070507080101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,all
      My first NAPI eepro100 contains a subtle but fatal race,which will 
lead
to lockup(of the whole machine here,but of ether interface for paul). This
version should be ok, Paul, would you like to have a try? I've tested it 
in my
pcs,it seems very stable now. Even 50kpps traffic won't cause any problem
here.
      The bug is explained in the comment,i think NAPI driver writer 
probably
will meet it,so it is listed here.
     /* disable interrupts here is necessary!
         * We need to ensure Rx/RxNobuf ints are disabled if in poll
         * flag is set. If interrupt comes bwteen netif_rx_complete
         * and enable_rx_and_rxnobuf_ints, the following will happen:
         *         netif_rx_complete --> clear RX_SCHED flag
         *           -> ints(e.g. TxDone)
         *                  speedo_interrupt
         *                       if (netif_rx_schedule_prep(dev))
         *                          disable_rx_and_rxnobuf_ints
         *                  return
         *           <-
         *         enable_rx_and_rxnobuf_ints
         *  then we will have Rx&RxNoBuf ints enable while in polling!
         *  it may lead to endless interrupts and effective lockup of
         *  the whole machine.
         */
        spin_lock_irqsave(&sp->lock,flags);
        netif_rx_complete(dev);
        enable_rx_and_rxnobuf_ints(dev);
        spin_unlock_irqrestore(&sp->lock,flags);
 
  Sorry for my delay,it is all the world cup's fault:)

Robert Olsson wrote:

>Paul writes:
> > Man well I tried 2.4.17 kernel
> > eepro100.c driver patched with NAPI and as soon as 
> > I route traffic to it it destroys eth0 and eth1 which are the two
> > interfaces that take the traffic.. they just die.. nothing in logs
> > nothing in dmesg, no errors, just all of a sudden no traffic
> > can go in or out those interfaces... sigh.. 
> > I then took the driver from kernel 2.5.21 and put it in 2.4.17 and compiled
> > after patching with NAPI and had the same problem..
> > 
> > You have any idea what the deal is?
> > 
> > It just dies instantly..
>
> Honestly no, just uploaded the eeproo napi patch from Zhang Fuxin he might 
> have some ideas. 
>
> I'm struggling with napi variant of the D-LINK sundance driver for 4-port 
> board myself.
>
> Cheers.
>
>						--ro
>
>



--------------080207080103070507080101
Content-Type: application/gzip;
 name="eepro100-napi.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="eepro100-napi.tar.gz"

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
LnWpS//v9C90Wo1DAHgAAA==
--------------080207080103070507080101--

