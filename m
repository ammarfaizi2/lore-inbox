Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130633AbQKTAiy>; Sun, 19 Nov 2000 19:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbQKTAio>; Sun, 19 Nov 2000 19:38:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130633AbQKTAid>; Sun, 19 Nov 2000 19:38:33 -0500
Subject: Re: 2.4.0-test11-pre7: isapnp hang
To: twaugh@redhat.com (Tim Waugh)
Date: Mon, 20 Nov 2000 00:09:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001119233450.H20970@redhat.com> from "Tim Waugh" at Nov 19, 2000 11:34:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xeWC-0003AP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Reading from port 0x313 (my ISA NE2000 is at 0x300-0x31f) hangs my
> machine dead.  Unfortunately, reading from that port is exactly what
> the isapnp code does on boot, if compiled into the kernel.
> 
> Is it the network card's fault (probably), or is there a less invasive
> probe that isapnp could use (unlikely, I guess)?


That shouldnt be possible - we are supposed to start at 0x203 and skip the
problem area.


static int isapnp_next_rdp(void)
{
        int rdp = isapnp_rdp;
        while (rdp <= 0x3ff) {
                if (!check_region(rdp, 1)) {
                        isapnp_rdp = rdp;
                        return 0;
            	}
                rdp += RDP_STEP;
                /*
                 *      We cannot use NE2000 probe spaces for ISAPnP or we
                 *      will lock up machines.
                 */
                if(rdp >= 0x280 && rdp <= 0x380)
                        continue;
    	}
        return -1;
}

If you can find out why that port is being touched I'd like to know

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
