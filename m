Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRE2Jbk>; Tue, 29 May 2001 05:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbRE2Jba>; Tue, 29 May 2001 05:31:30 -0400
Received: from Prins.externet.hu ([212.40.96.161]:43025 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S261473AbRE2JbT>; Tue, 29 May 2001 05:31:19 -0400
Date: Tue, 29 May 2001 11:31:16 +0200 (CEST)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: linux-kernel@vger.kernel.org
Subject: tcdrain() problem?
Message-ID: <Pine.LNX.4.02.10105291046410.4560-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I use the serial line for communication with a device.
The communication looks like this:

1. ask the device about its state (a 4 byte packet)
2. read reply from device

3. decide what to do:
   3a. if nothing to do, go to 1.
   3b. if there is something to do, send the answer to the device
       this is a 23 byte packet
   3c. if the device ack'd the previous action, counter-ack it.

This is the function I use for sending:

void send_message(int fd, ptg_t *ptg, int sleeptime) {
        int     len;

/*	tcflush(fd, TCIOFLUSH); */
	if (sleeptime)
	        usleep(sleeptime);
	len = ptg->message_out[1];  
	write(fd, ptg->message_out, len);
	tcdrain(fd);
#if DEBUG
        {
         	int i;
         	printf("%d sent: ", ptg->ptgnum);
         	for(i = 0; i < len; i++)
         	        printf("0x%02x ", ptg->message_out[i]);
         	printf("\n");
        }
#endif   
}

The line is full duplex, 19200 baud, 8N1.
The serial device if opened with O_RDWR|O_NOCTTY|O_NDELAY.
My problem is that if the tcflush() is not there,
sometimes between the "there's something to do" reply 
and the longish answer somehow a "what state are you in?"
message goes out. This simply couldn't happen from the
program data flow. I have put printf()s into every possible place
and it does not show anything unusual.
But an independent serial line sniffer (another PC) shows the
above problem, no matter what the sleeptime is. (15000usec - 60000usec)

So I suspect that tcdrain() does not do what the manpage says:

       tcdrain()  waits  until  all  output written to the object
       referred to by fd has been transmitted.

The above problem happened on two different PCs, the only common
thing was the uart type: 16550A.

Both PCs are running the 2.2.17-14 RH kernel and glibc-2.1.3-22 (RH 6.2),
the serial driver compile options and version are from dmesg:

Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled

If I put the tcflush() before the write, the problem disappears.

Now the question is: Should I really issue a tcflush(), or is it a bug
in tcdrain()? Can O_NDELAY cause tcdrain() not to wait?

Please cc the answer, I am not on the list.

Regards,
Zoltan Boszormenyi

