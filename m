Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbTLGNJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLGNJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:09:35 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:8708 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264423AbTLGNJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:09:29 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sun, 7 Dec 2003 23:12:00 +1000
User-Agent: KMail/1.5.1
Cc: AMartin@nvidia.com, ross@datscreative.com.au, andre@linux-ide.org,
       kernel@kolivas.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hcy0/DbWHu4lILX"
Message-Id: <200312072312.01013.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hcy0/DbWHu4lILX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,
I am not subscribed so please cc responses.
I have monitored list and know my nforce2 experiences have been common.
Attached patches are in a single bzip tar ball.

I have Albatron KM18G Pro & Epox 8RGA+ MOBOs both using nforce2 chipsets.
I made up a kernel as follows.
Get std 2.4.22 src
apply patch-2.4.23
apply 2.4.22-low-latency.patch
apply preempt-kernel-rml-2.4.23-pre5-1.patch
apply vhz-j64-2.4.22.patch

One patch fails on inode.c, dispose_list() so I placed conditional_schedule() as follows
=static void dispose_list(struct list_head *head)
={
=	int nr_disposed = 0;
=
=	while (!list_empty(head)) {
=		struct inode *inode;
=		conditional_schedule();

Config for athlon with 1000hz tics, preempt & low-lat on.
Compiled and installed nvnet & nvidia video driver.

Disclaimer: The following information and code patches are not fully tested and may be 
dangerous, also these are the first patches I have made for public consumption so I hope
that their format works.

Note also that the patches are against 2.4.22 even though they were developed
against the heavily patched 2.4.23 mentioned above. The patch code is the same for both
kernels but at different line numbers.

When I enabled either apic or io-apic in kern config, lockups came hard and fast.
Particularly bad under hard disk load. Heaps of lost ints on irq7 in apic and ioapic mode. 
Lockups disappeared when I lowered the ide hda udma speed to mode 3 with hdparm so
I went looking for answers which now follow.

There are three parts to this email.
a) apic mods.
b) io-apic mods
c) ide driver mods

a) Lockups are due to too fast an apic acknowledge of apic timer int.
Apic hard locked up the system - no nmi debug available.
Fixed it by introducing a delay of at least 500ns into smp_apic_timer_interrupt() 
just prior to ack_APIC_irq().
See attached diff file "nforce2-apic.c-2.4.22.patch" for details. 
I have guessed at a suitable cpu speed dependent delay.
Perhaps someone with AMD cpu docs (apic timing specs)  & analyser tools could refine it.

Maybe nforce2 chipset really is very quick accessing ram in dual dimm mode? 
Or AMD 2200XP has a really slow APIC?

--- linux-2.4.22/arch/i386/kernel/apic.c	2003-06-14 00:51:29.000000000 +1000
+++ linux-2.4.22-rd/arch/i386/kernel/apic.c	2003-12-07 18:27:32.000000000 +1000
@@ -1078,6 +1078,15 @@
 	 */
 	apic_timer_irqs[cpu]++;

+#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
+	/*
+	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
+	 * to stop lockups with udma100 drive. try to scale delay time
+	 * with cpu speed. Ross Dickson.
+	 */
+	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
+#endif
+
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.


b) I was also disappointed to see I could not have irq0 timer IO-APIC-edge. 
So I have fixed it too (tested on both my epox and albatron MOBOs).
Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic.
I have modified check_timer() in io_apic.c to trial connect pin and test for it
after the existing test for connection to io-apic.
See attached diff file nforce2-io-apic.c-2.4.22 for details.

--- linux-2.4.22/arch/i386/kernel/io_apic.c	2003-08-25 21:44:39.000000000 +1000
+++ linux-2.4.22-rd/arch/i386/kernel/io_apic.c	2003-12-07 18:40:40.000000000 +1000
@@ -1614,9 +1614,44 @@
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
-		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC pin%d\n",pin1);
 	}

+#ifdef CONFIG_ACPI_BOOT && CONFIG_X86_UP_IOAPIC
+	/* for nforce2 try vector 0 on pin0
+	 * Note the io_apic_set_pci_routing call disables the 8259 irq 0
+	 * so we must be connected directly to the 8254 timer if this works
+	 * Note2: this violates the above comment re Subtle but works!
+	 */
+	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...\n");
+	if ( pin1 != -1 && nr_ioapics ) {
+		int saved_timer_ack = timer_ack;
+		/* next call also disables 8259 irq0 */
+		int result = io_apic_set_pci_routing ( 0, 0, 0, 0, 0);
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		unmask_IO_APIC_irq(0);
+		timer_ack = 0 ;
+		if (timer_irq_works()) {
+			if (nmi_watchdog == NMI_IO_APIC) {
+				disable_8259A_irq(0);
+				setup_nmi();
+				enable_8259A_irq(0);
+				check_nmi_watchdog();
+			}
+			printk(KERN_INFO "..TIMER: works OK on apic pin0 irq0\n" );
+			return;
+		}
+		/* failed */
+		timer_ack = saved_timer_ack;
+		clear_IO_APIC_pin(0, 0);
+		result = io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC Pin 0\n");
+	}
+#endif
+/* end new stuff for nforce2 */
+
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);

c) Finally during my fault finding I merged A.Martins patches for the nforce2 IDE driver.
I note that the nforce2 address setup timing bits are different to the AMD ones.
I have assumed the nforce2 address timings apply to nforce and nforce3 chipsets.
I could be wrong so if someone with the nvidia docs could check it please.
I have also not tested it with anything but a WDC ata100 hard drive.
For info see attached patch files (I think pci ids are already in 2.4.23)
nforce2-amd74xx.c-2.4.22.patch, nforce2-amd74xx.h-2.4.22.patch, nforce2-pci_ids.h-2.4.22.patch

Thanks
Ross Dickson
--Boundary-00=_hcy0/DbWHu4lILX
Content-Type: application/x-tbz;
  name="ross-diffs.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ross-diffs.tar.bz2"

QlpoOTFBWSZTWW1SscwAF8X/pP43DUB7/////+//7v/v//8AQAABAAhgFDz0UfStuDm20bb3Hjt5
nbQ1uzKigHlp4wmUJW22vTdtkANsswy3duetUV2QkkITFE9qaaaeplG1NkzSJ6aNI0zU0BoABoAA
AABohNU81MmZU2hNAAAaAD1AaAAAAAAABwADQaGg0AGmQaGQNNAAAZABkBkABISQCTJPU09Ek/QJ
6DVPKeUeEzSnp6p6QPU9QPSeoNGmj0gZPUyCJREYpim1T9Kek9PKJ5TT001PFMhoyPRGJo0yZDR6
jIANNMQEiIIJpoCNNTEZCap+inqZHqafqmwobKep6mmh6gBoAANN9vuR/II32EaSyHExDuEhHb7f
KYRJdqdyWuty8t9CPgyBdFOIkQjuWuLlMO5AbpDENLAHoBvBUoSQkgklsoBCLIMiyQi0SkSiTSis
m3mY+nLKvGW/gB+5ge7QNGaDG4NjUNUlMGSFVRUKpwjoHTqm4MnesVTLOMG4xojQIG4fWQJUXobf
qGvIapJISiGoDKBFy1Q/gCxfGBaBha70UaYA3qckToY4Uqg5Bxx04xg6gVREDkQQp00R0mDCLdXm
4ul8dPmk/6YCUSYJOjgulP3tbqutYza82N9ao7qZzSPZWToWcWq5pW9pILoxm8oiIUFqEp2iG2xh
ZlTPe16k+Pz9nr49m7kPx1bXt6NOLfTjmwa6N82sHJFtIdD0zdggurB5MmThbKLjkoaz3+n89Vgb
jy6v3/ZpmeDWhuHEeNKOiir2d7iciUXt4PlkJcpfLCVEbc3OnmaEqX9E22ubeEuGb2bvlX2kplVH
iXUx4sUZiN+F8KJETgREtgDSKJF3kaS1YJf2BdSVSh2PMrIpizKHh6t3v/UTPrRzGUyU6FR8tnRB
e/7OBzr4r5x7W0pgy+Xzc3JTbCyWUHwMKXeXeEwGIjpiw1dutGEjI3AwvKsBFIFLp6s0jh8GBk3B
qt2eTsnDrnxywGBp7DcEBX67fcZ5kqowXt+FVh1ZbnOb7SUNJYhQUUBPx6QEWI2OIR4sejYe941l
z2e4aMc5kNBSrkEiSddOiCV1+HVB1290uctfMh+ZH3yT6+LmPHXfRE5EfKxDt3Vd4r3fyMLBYf31
m7CaUJO4NeFeMabVkj2MPIZR3ciPCFPGMme2jTSbAYgbT2DnZSwDRKayGbzCt6Bb3wrDJcbabBjs
Jtxtg2sWR1WwYAeV2zRKAkVBy8l1Zz3aUyjyZf+RNLCFxbEcCrkv+c2BgZaB9Xjea+MK3i/34l8D
QGjeb+WyhHH3e1HzNunriakKhSkkcPFHgvQe2RkROuUEUhERwgE79my7rct3vMeoFXfDppk0mrSe
rFKn2oNmIOFVVVJKJSa/Mei2HD1aper0rPXPAtQ8u2+wZx/XoUW3E0yuh4Lh3PRcCrCMblUTRcE7
qYnxbpvBNunTVibaHO65KLL64iJbNo1L3FZvVp7/frlvE+b0/Ln214/RHo+KIPRHccg67UD7dTPj
l89cQKRCUkAupEOl3W8Oi8OhycXnRsRp6WbtXhXZddIud0hFdmoyQiBjy+yZsElm4CuwVUbywKq2
0cxjRCmmdS4Ej9BMUyzWEQ0Jd7NnDS7xn3ZWqrM6vcmsy28Ees29Ky0eWwagSU0uu5cdrR5hqhcQ
QLktEFrMW4s+KO87UipNWy5abIe8WeAwFqCWp209yjTBvkjh5z+zFB27pKvt4jAMFMssOtBvOKF3
Nu+EvhQ9HHuYZcqkiSLIHDBkISHZp905MeOugIIxhCSQIoXRDVZQ4CLznetqYoJIv0Q7E9mCeVga
e1w9ZzFqYIHpYUOlMwmqaGDbZrRZV9BSnn2XlK3wIgnCKk/2JOEWAlK1nb37+MnikekdNHEQC8HP
OxNWqklYnJKri7hXvKG/wB848K3jE/KTpS34sulme+slBu25rejcPSTpZQHzUwlsinYR7XM/h77f
TN/Z8Iw6zno+MVkwY43nWeUx56tflvzDF+RekvYmNptNNtJjTENAug0HwtBXlBJEbA4kNQUF1Yjq
OwhrQEtq/Wm7gMHVSDsL+q6/Vh1Xp3hdL7zvYTepykSg1YUY6peHxff9/198Xe7YJvQPYQE1CBTf
Id8oyVp1h9UuhYlXlEsuUtb0EZmS99ux+YUiZrtDan2q/K79mHy/sRali083evQCyDgAwN4G4nvf
OKVZTiMrFKOOR7XhWTne02pesYulGWxh2c3h4a/aepCBsPNNMEQhtI//R0K11V0Muk0PamHqR9h9
o4RJqMS9AzsDza6EOIYUZWrSAQNJ7bqf3NcTOJ2Opyslehx79T3baQxRv+53fcKp5nU9XTd51hUS
TSVhfrgfgH38GNtkQKbW24JBei/7pXcQLYBGNPkgRtbbl7Bh5i1zKHAZ1tmZmbCFcHvgRhcFoEwn
7LaYJQ/RSflogyZ1B/VaDrBBLwn/bqEFAbML1oL4DTzhjUMCwmSMKnIKVoSUbQNaVnqMiQsBiHk0
jYKqaQqSPaIxkR1BF94iyIzNSneO2JALVPp8DUMkNAWv7GlgLOBDR4qBNFkUKKSxUbWa4QcZ/JJz
CReCPWA0wGwBwGxpge0QwYmtwML9zMtm0srEHFw7PbKLNCuUq60pECKINmN/LnxpZ8OzFH/lYgPg
w7zIRQqig86Q415Jmt3qKv53etlsjWqMa56MNGVDZqZ7eiMYDJReMSbUb/NymtYYL9s4FeRYsDpw
NAObnJxfCYM60RhaWYBUDJ8bYzCLIzR2XwNUlQR1N8+Aik8HY7kk7bawq9voCzRGzWtt0RzMnO7K
/FHVHmiQOOewJbw5eCSo01k8mcyQG0RutgIkxe7Xwk8Lpd522L2MzjfB2mto2UJ9wWmwaBqHPBDE
TndTxCUEkF43V6JLgJabdLEMiygpcrOxEo6Xomb6WvdESQycDRYIEOD224Z4ZJkX1ZaMcdaXiu0R
cjHam2i2EXxx2xysiliGsnJpolA8mQQVFhs7qcFNqBXHfGkVwHeNlkYoaIj1lS2i7C8qM4nqkK1z
zW2GOqppCMgZAkUCegOBEiWiGR0zjMzjQgHRABB+Kshb9yQYQeZ2uIpZWGkTjdqJJhNnrD+QA4Mt
NvCizSZlYPzxdhQ8vs7kqNNt8zaY7ZcV45O1XK+/L5JwaxLnXzw+LG/S6cfDvNkOPixqWKV3p1ux
CHSZ+Hyb9tPS1hX8mFLMJ50nO8YOnrrW9vG9tM5V9saNSuWyQ1u5msQtgM1ZZ0pzkl86x73RrmG3
b/agcwLxAR7rDdiHeJ4raLAKYiryBYBZACEhVaKkQIBFqASBAHbUTYoGtAfIAsBe0C9s/A3KBSIE
kcVEP68OPffL+JUqZ+cI2oA2NNITEevY25GpQHszELu7wBB6zhDFZLunlK1aQ1ZCmgBECc/SgRh6
KMEVV+DWnJrWdgIgyxKEESE0hZfUa9rajBt6ARQYAcCX9fiWegs0DFGRJEKEFcLHs8ug7MQz1U/u
3xGfzLDA+MaPLORHZMmcijkzUoizOcaN+gflfmZbVXTGW9Ia2QkZCMey++cwFuFwQJhiIu0JjHIC
gAO44Jc0pWKLhdSz1KAwJzyxStZ5gYNA3xbtNOCzAdiyLjudS30MiK6hFznViaOV3GeR6egHEV1Q
qhtKEbDsGlI2hGYFu8VB9gXEa8aYgWkTpiXQG5LBY6wFz0cDsWtA97SAsbhGw3mvhOhngf78Su4h
YnDBAZ1KCfboSlVJpGXq5UWatYgNDafv43uBu5k49DJHhfMCpS/vxxDsrAXBdopnNAFAL0G0BoYV
uNsM5tQhzyw03UdMQ6O5lygd18B10oQodfke5n9MShYmPiY5CpU2ePhFuv0IF8gm2fOmfdb6aLik
LfNRgHRc50aSO7B88OgBvBRt02Vee0QenTIWt27WZgeLn25VVEqpHMDKwDE0BkuXVzcZq2YwFigU
EzjyN1i3x2JtSBMaBtJjbD7aZpSX7qayffuS6nbiVhSixfGOk7aWhqtQPBagU2xHYCDD7xcly3EQ
XAxmKoUxCwggpwMFgtlkt54yevIzts7thGhRYlFpogg+NOxZD3xtOi0vo+YeB7WcyN/7ARowsDQo
wQPHkZJMU8i0nMbhwlAvT5xSPResqV7KVCXGdVhn+0ZoxJi0iGQ1MoIJrWBt+bVaCTz0bNGsevtR
gg1mATLh4ILyoiv1XPjR7Di4dSQcOnmA9bN0HUuvtPXze1F3L3AUBEGMQub9jSsiouu4vghVg7ge
QSgZrgwHJYBpSRSOXQtQ6CNAMUFjWHXaCmI3CFsS0MwijhDSjaGhdLBrwIvKShKgyQf4+GPFFUZg
zdij5kvwbXSS+LGeiLRibEMxJ61Eqws/ahKpx3AJY2QlExxAzDBSwjXZs2DOYKmozegS3GM8lxTA
9kLqAxYhrdYdWRoBZLSGxhEQkMagYDQmHpKmbF0fmPBeWCsjbrZ/eRVnsDI3Ki7APWB6PLvpRblu
Co2NtxLlKsz/Ff9X5PdNTmc8anjbYZfLRF8lswvIxoKvbYVhFHSvQhZItYYtWldg6uNgKyRltR+1
QMEPDZcO8GOos2Es0kKJUZYt7gu0GxYsScoITA7jHFa1bTPDxA7EdW/Stq26Uj1bKypaiZgJS40h
9wcUVD6jd5O3SpPTQwSFsctBIHFCXM14d4hdDHbKPeDEBje0llHaFzFJdlBLxF07slYR53DIkxYm
8xNIzUII2SbKAq+sXNG+DN3VHRQTXBIbIA0RgiE4IawOQ1558Q+Y0fjQ89d669X16F0dugmYN4Kc
IrUEsGeKNwe1pJiPMF8I2dBctgTkeog27Whm9v2BRe8DUodjXYwJvBUEHuPNJdQXh5diEsOX0xJB
0FytrvWbHSgO1odsDWQixCAQSJcKtQbWzWo0tDQR7GajWeLBas9pEu8CN1xSaY6KXZ5UAHE9ih3g
Ikt8Gg7AjQZHSX1wdQYNlKxO4NtQouB70HUXnC+PTTPAJGcYEfG0d0kD5MRqXC6RIabtgiuxWPTb
TlfNAg28CmSAFJ4JiVKLUlCq9+tn305DqrZmckurH/8i0sqlEygoWawEQAvEChhPCcOdjbGwW3Mm
0DfRMAgFC9WBu8HW5n/d/IF0ZBUJk2N+VTXR4sqdTGDaQuH1IklSLSKsB9Q8WVZEgcOJ3oXeWEuu
iZX1iw9LKhm7aXAGZaIMrdWcmSWPDaExa9gNsB9lBrR8nc2hR1yIz5aBgeq7w0C1oV7c8OFkF9FQ
RrDbcw82MI1YcxHbBxFhH9IZZlpRscay+tq5MyhrvtaBF2pHXkUmB1IU7IhGmNEtGwg0dNnV5bAF
UNcUV0pqLoid4zd3xq6IbWB8tRHpW8BaC3qzQwqvxI8TatBFrJHBG4YdyNyPACcRKAGTKCpsZAb1
KFShqpYawpxRAIENZZUijkBT0IIhGYFH5DQcBP0ruU9jtxBamSnN73Y8RqAyOIW3HZoVEcf0YqRu
Rpsb2s0TMsDf0gFy1Jduyq1MQsqYs+rDOTujL53dVKG+wSq6G+V7NGhmu6MRkgBjQLCKXyGRncAo
i1oO3kREMzRTrfDSljJChIGg3msPe4hMGEblgZg0vKLAUEnnOcIkt7dgG4rlCAjMXXisYPo6o5mZ
2gW+7Yj91EnJOobiZXZzF2redsUtZDYqOOWQSggHDtw+xHg+1GrFXCW8hcS4hgoW6YI22OfAoVBi
uJWSwPwzWByEczltue4EiaG6xLdiG1zUXnKQYYIKUSAZXwgJzS/okjcc6Yk9yNny8ZsEuQZEwZzr
ngUj/KGmmAoJp1Ihu4gf293079rX/rgqO0AwO2BHhRP/F3JFOFCQbVKxzA==

--Boundary-00=_hcy0/DbWHu4lILX--

