Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290926AbSBUJrP>; Thu, 21 Feb 2002 04:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291152AbSBUJqz>; Thu, 21 Feb 2002 04:46:55 -0500
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:51849 "EHLO
	server1.i-a.co.uk") by vger.kernel.org with ESMTP
	id <S290926AbSBUJqs>; Thu, 21 Feb 2002 04:46:48 -0500
Date: Thu, 21 Feb 2002 09:46:46 +0000
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: linux-kernel@vger.kernel.org
Cc: alec@bugs.shadowstar.net
Subject: Re: HPT372 on KR7A-RAID
Message-Id: <20020221094646.1c499b6e.lkml@andyjeffries.co.uk>
In-Reply-To: <Pine.LNX.4.44.0202210427050.27301-100000@bugs.home.shadowstar.net>
In-Reply-To: <20020221091319.37e74cba.lkml@andyjeffries.co.uk>
	<Pine.LNX.4.44.0202210427050.27301-100000@bugs.home.shadowstar.net>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 04:28:31 -0500 (EST), Alec Smith <alec@bugs.shadowstar.net> wrote:
> Did you check Andre Hedrick's IDE patches at http://www.linuxdiskcert.org?
> For unexplained reasons, the power penguins refuse to take Andre's work
> into the standard kernel even though he's the official IDE/ATA maintainer.
> Andre may have already solved your problem.

In Andre's 2.4.16 patch (from that website), the chipset_names array still
doesn't contain the HPT372 chipset and I'm guessing it will still panic
the kernel because at lines 1433-1437 of the patch it says:

+		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+		class_rev &= 0xff;
+
+		p += sprintf(p, "\nController: %d\n", i);
+		p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);

Now, if the class_rev is one higher than the number of items in the array
(which it is because chipset_names is now called chipset_nums but it just
contains slightly different strings, i.e. not starting with HPT) it will
still reference an item in the array beyond bounds.  A hacky patch my boss
found on the internet (he's the one with the motherboard) did the
following:

+	if(class_rev >= (sizeof(chipset_names)/sizeof(char *))) {
+		class_rev = (sizeof(chipset_names)/sizeof(char *)) - 1;
+	}

I think this is awful, but as I said, I'm not a good enough Kernel
programmer to die gracefully or depending on a passed in parameter fake it
to be the end of the chipset array (which the dirty hack above doesn't
solve, if there are two further revisions it will break again).

Kind regards,


-- 
Andy Jeffries
Linux/PHP Programmer

- Windows Crash HOWTO: compile the code below in VC++ and run it!
main (){for(;;){printf("Hung up\t\b\b\b\b\b\b");}}
