Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbRESV73>; Sat, 19 May 2001 17:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261591AbRESV7T>; Sat, 19 May 2001 17:59:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55467 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261449AbRESV7I>;
	Sat, 19 May 2001 17:59:08 -0400
Message-ID: <3B06EC99.B23A1F8@mandrakesoft.com>
Date: Sat, 19 May 2001 17:58:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4-ac11 network drivers cleaning
In-Reply-To: <200105192141.XAA02258@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks decent.  Adding module descriptions was quite nice.  One
flaw that is repeated multiple times is that you add

	#ifdef MODULE
	printk(version);
	#endif

in an ISA driver's probe routine.  This instead should always be the
first operation of init_module.

Also make sure to go through the 'ac' patch and review the earlier
version string changes.  Some of them were buggy, like

	static const char version[] __initdata =
	"...";

const combined with __[dev]initdata causes a section type conflict.  A
few of those popped up after the earlier patch was applied to 'ac'.

Finally, I don't know if I mentioned this earlier, but to be complete
and optimal, version strings should be a single variable 'version', such
that it can be passed directly to printk like

	printk(version);

Some net drivers are already like this, as I'm sure you know.  Some net
drivers have 'version', 'version2', 'version3' instead of just one long
string.  Some net drivers add KERN_xxx at printk time, instead of adding
it to the 'version' var.  Some net drivers do the following, which is
really silly considering you know all strings at compile time:

	printk(KERN_INFO "%s\n", version);


-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
