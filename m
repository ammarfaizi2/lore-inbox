Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932299AbWFDXJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWFDXJP (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWFDXJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:09:15 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:64936 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932299AbWFDXJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:09:15 -0400
Date: Sun, 4 Jun 2006 20:12:23 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, rmk@arm.linux.org.uk,
        gregkh@suse.de, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060604201223.7cd37936@home.brethil>
In-Reply-To: <20060602154723.54704081.zaitcev@redhat.com>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
	<1149242609.4695.0.camel@pmac.infradead.org>
	<20060602154723.54704081.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 15:47:23 -0700
Pete Zaitcev <zaitcev@redhat.com> wrote:

| On Fri, 02 Jun 2006 11:03:29 +0100, David Woodhouse <dwmw2@infradead.org> wrote:
| > On Thu, 2006-06-01 at 23:48 -0700, Pete Zaitcev wrote:
| > > 
| > > >  The tests I've done so far weren't anything serious: as the mobile supports a
| > > > AT command set, I have used the ones (with minicom) which transfers more data.
| > > > Of course that I also did module load/unload tests, tried to disconnect the
| > > > device while it's transfering data and so on.
| > > 
| > > Next, it would be nice to test if PPP works, and if getty and shell work
| > > (with getty driving the USB-to-serial adapter).
| > 
| > xmodem is a good test -- better than PPP because it stresses the
| > buffering in a way which PPP won't. Log into a remote system, try
| > sending and receiving files with xmodem.
| 
| I understand. My intent was different, however. One of the bigger sticking
| points for usb-serial was its interaction with line disciplines, which are
| notorious for looping back and requesting writes from callbacks
| (e.g. h_hdlc.c). They are also sensitive to drivers lying about the
| amount of free space in their FIFOs. This is something you never test
| when driving a serial port from an application, no matter how cleverly
| written.

 Okay, I've made some of the tests suggested by you.

 I connected to my computer an USRobotics external modem (which uses the
standard serial driver) and the cell phone I have available for the tests
(which uses the pl2303 USB-Serial driver).

  In all the tests the modem was configured to answer the calls, and the
cell phone was configured to dial to the modem (my home's number).

  The reason for that setup is economic: my cell phone has some additional
credits (read free minutes) which I can use w/o spending money.

  Thus, we have something like this:

            Phone call from the cell phone
            /- <- - <- - - <- - - - <- - \
            |        ------------        |
            \-------o| computer |o-------/
  modem (phone line) ------------ GSM cell phone (pl2303)

   (I know, I know. I will never try to be an artist)

1. xmodem transfer test

 I transferred the following picture (48K):

   http://www.cpu.eti.br/pics/monkeys.jpg

 through minicom using the xmodem protocol with both USB-Serial versions: the
current one and (my) Serial Core port.

 Unfortunatally, I could only make one transfer for each USB-Serial version.

 Results:

   1.1 Current USB-Serial version

      o Received picture:
        http://www.cpu.eti.br/pics/usbserial-curr/monkeys.jpg

      o Got two TIMEOUT errors

      o md5 check didn't match

      o minicom's summary:

         20060604 12:20:19 Bytes Sent:  47488   BPS:161
         20060604 12:20:30 Disconnected (0:05:37)

  1.2 Serial Core USB-Serial version

      o Received picture:
        http://www.cpu.eti.br/pics/usbserial-sc/monkeys.jpg
 
      o Got seven TIMEOUT errors

      o md5 check didn't match

      o minicom's summary:

        20060604 12:08:34 Bytes Sent:  47488   BPS:113
	20060604 12:08:48 Disconnected (0:07:44)

 In both cases there is no visible problem in the picture and both md5 checks
failed. The only significant difference is the speed.

 However, note that this V0.0 of the port can be improved in many ways
(take a look at the pl2303's start_tx() method, the do-while() loop
isn't necessary, for example).

2. Remote login

 I've setup a remote serial console using mgetty. And, for both USB-Serial
versions, I could log, execute some commands and edit a file.

 I didn't notice any problem.

3. Conclusion

 IMHO, these tests can only be used to show that the USB-Serial Serial Core
port is feasible.

 Unfortunatally this is a very expensive test environment, and I can't use
it for development. The best one would be to have a USB<->DB9 cable..

PS: I didn't translate the picture message because I'm afraid I can't
make it as funny as it's in pt_BR.

-- 
Luiz Fernando N. Capitulino
