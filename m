Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLWGDh>; Sat, 23 Dec 2000 01:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLWGD1>; Sat, 23 Dec 2000 01:03:27 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:47066 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S129387AbQLWGDT>; Sat, 23 Dec 2000 01:03:19 -0500
From: Stefan Hoffmeister <Stefan.Hoffmeister@Econos.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 driver broken? (2.2.16)
Date: Sat, 23 Dec 2000 06:33:31 +0100
Organization: Econos
Message-ID: <ap984ts403g459gm53l17ll8h4suoklf9s@4ax.com>
In-Reply-To: <vb074t8d27bdedg6m7pv4c4qqu1f8324cq@4ax.com> <E149X1l-00051k-00@the-village.bc.nu>
In-Reply-To: <E149X1l-00051k-00@the-village.bc.nu>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Fri, 22 Dec 2000 18:34:46 +0000 (GMT), Alan Cox wrote:

>> Questions: 
>> * Is the rtl8139 driver broken?
>
>Somewhat, especially in kernels that old

We do live on Internet time, I know, but has it gotten that fast that the
latest distributions ship with kernels "that old" ;-)

>2.2.18 might help and also as an '8139too' driver rewrite which may work 

I am now running SuSE 7.0 and have replaced the supplied (2.2.16) kernel
with a stock 2.2.18 kernel. The situation has improved, but in the end my
problems persist.

The rtl8139 driver continues to exhibit the old problem: ping with large
packet sizes kills off the external connection. The connection can be
resurrected by "ifconfig eth0 down" followed by "ifconfig eth0 up".

The 8189too driver handles large packet sizes *much* more gracefully; I
now can "ping -s 5000 192.168.0.55" - which gets me 100% packet loss -,
but a "ping -s 500 192.168.0.55" works perfectly (0% packet loss) even
after doing that.

The major problem I have is that FTP'ing to the machine slows down to a
*major* crawl at random (?) places. Example:

  192.168.0.77 = Realtek 8139 (8139too) 2.2.18, in docking station
  192.168.0.55 = Intel eepro100 (eepro100, 2.2.16, SuSE 7.0)

>From 192.168.0.55:

  ftp 192.168.0.77
  binary  
  put <file> // 3 MB

* Up to 40% transfer all seems to work smoothly (varies)
* Transfer stalled (for 30-35 seconds)
* Sudden burst of activity up to 65% (all smooth)
* Transfer stalled (for 3-4 minutes!)
* Sudden burst of activity up to 100% (all smooth) (varies)

Data transferred successfully; but 3390679 bytes sent in 05:12 (10.59
KB/s)? This cannot be right. I got 730 KB/s when transferring the pristine
2.2.18 kernel over the 10 MBit/s PCMCIA NIC.

All this is on a 100 MBit network over a hub; there is no network traffic
except the FTP. 

I get a massive amount of log entries:

  kernel: eth0: Abnormal interrupt, status 00000041
  <repeated many times>

Interspersed are single occurrences of

  kernel: eth0: Abnormal interrupt, status 00000040
and
  kernel: eth0: Abnormal interrupt, status 00000045

AFAICT, these are directly related to the FTP transfer: I connect to the
machine, get the log entry, start FTP'ing, and get all this mess in
messages.

Some more digging seems to indicate the following:

  ping -s 4500 192.168.0.55

gets some major packet loss. For each packet lost, I get one of these
"Abnormal interrupt" in the log.

I notice that "Version 0.9.10" of 8139too ships with the 2.2.18 kernel;
there is a "Version 0.9.12 - November 23, 2000" on
   http://sourceforge.net/projects/gkernel/
but that won't compile with the 2.2.18 kernel (as advertised in the
readme)

The changelog of that new version contains (amongst others) these entries

  * Kill major Tx stop/wake queue race
  * Replace timer with kernel thread for twister tuning state machine
    and media checking.  Fixes mdio_xxx locking, now mdio_xxx is always  
    protected by rtnl_lock semaphore.
  * Sanity check Rx packet status and size (Tobias)
  * When handling a Tx timeout, disable Tx ASAP if not already.
  * Do not abort Rx processing on lack of memory, keep going
    until the current Rx ring is completely handling. (Tobias)

I have no clue what all this means, and neither am I competent to backport
the diffs to 2.2.18, but I sure would be curious to learn whether any of
the above changes could make a difference to the problem I observe?
http://www.afthd.tu-darmstadt.de/~dg1kjd/stuff/ (Jens David, apparently
2.2 backport maintainer) does not have any updates.

Any ideas? Any leads on how to proceed?

TIA!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
