Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRHOV2H>; Wed, 15 Aug 2001 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRHOV15>; Wed, 15 Aug 2001 17:27:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:8663 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S264669AbRHOV1s>;
	Wed, 15 Aug 2001 17:27:48 -0400
Date: Wed, 15 Aug 2001 22:27:55 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Robert Love <rml@tech9.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <133218293.997914475@[169.254.45.213]>
In-Reply-To: <997908956.733.102.camel@phantasy>
In-Reply-To: <997908956.733.102.camel@phantasy>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

> Method one, your idea, would have us add SA_SAMPLE_NET_RANDOM to each
> NIC's request_irq call.  The random gatherer would then need to be made
> aware of the sysctl and check and add/remove interripts derived from
> NICs as needed.  This would require a bit of recoding (take a look at
> request_irq and random.c)

Hardly any - apart from adding a (new) SA_SAMPLE_NET_RANDOM to request_irq
in each drivers/net/*.c, you just need (manual diff) in handle_IRQ_event:

         } while (action);
-        if (status & SA_SAMPLE_RANDOM)
+        if ((status & SA_SAMPLE_RANDOM) ||
+            (entropy_from_net &&
+            (status & SA_SAMPLE_NET_RANDOM)))
                 add_interrupt_randomness(irq);
         __cli();

and then the completely trivial /proc (and/or sysctl if that's
really necessary) code for twiddling
/proc/driver/entropy_from_net (or whatever it's called).

+	int sysctl_entropy_from_net
...
+        {DR_RANDOM_ENTROPYNET, "entropy_from_net",
+         &sysctl_entropy_from_net,
+         sizeof(sysctl_entropy_from_net), 0644, NULL, &proc_dointvec},

in somewhere where it gets into dev_table in sysctl.c -
and that's about it.

Given distributions normally have installers with 'hints' as
to whether they are running headless or not, this could
via some rc script write a '1' here if the machine was
perceived as headless, or leave it default (0) otherwise.

--
Alex Bligh
