Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEVLi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEVLi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEVLi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:38:57 -0400
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:24483 "EHLO
	mail.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S1750769AbWEVLi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:38:57 -0400
Message-ID: <4471A2CD.8070404@physik.uni-muenchen.de>
Date: Mon, 22 May 2006 13:38:53 +0200
From: Patrick Fritzsch <fritzsch@physik.uni-muenchen.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050908)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange latency problem with local_irqs_disabled in kernel mode.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have a dual core CPU, where i made a linux kernel thread, which i
wanted to run on CPU1 without interruption.
so i disabled in a critical test-section the local IRQs and made some
time accounting, to see how much time the CPU needs to do his work,
which should be always the same. i moved all processes, which are not
binded to CPU1, to CPU0 before this.
I my theory there shouldnt be any interruption of the code....so the
time needed for it should always be the same, but thats not really true.

I have this (next paragraph) in my log, where the second big number is
the amount of instructions the CPU needed to do his work (which should
always be the same). The first is the current worst number. As you can
see the actual work the CPU did is jumping around from 68719579672 to
73014444248, but those 2 numbers seem to be quite, but not 100%, stable.
I am sorry to bother you guys with this in such a loaded mailing list,
but i think i have one (or maybe more?) basic missunterstaning in this
matter (maybe in relation with the linux kernel/or in relation with the
CPU), which someone perhaps could show me. Why is this number of
instructions not always exactly the same?

=== log:
May 17 20:31:29 localhost kernel: [  647.836400] New worst 68719579672
68719579672 1
May 17 20:31:50 localhost kernel: [  669.311268] New worst 68719579672
68719477376 2
May 17 20:32:13 localhost kernel: [  692.128314] New worst 73014444664
73014444664 3
May 17 20:32:36 localhost kernel: [  714.945358] New worst 73014444664
73014444248 4
May 17 20:32:59 localhost kernel: [  737.762401] New worst 73014444664
73014444224 5
May 17 20:33:20 localhost kernel: [  759.237266] New worst 73014444664
68719476976 6
May 17 20:34:48 localhost kernel: [  780.712130] New worst 73014444664
68719476976 7
May 17 20:34:48 localhost kernel: [  802.186996] New worst 73014444664
68719476976 8
May 17 20:34:48 localhost kernel: [  823.661861] New worst 73014444664
68719476976 9
May 17 20:34:48 localhost kernel: [  846.478903] New worst 73014444664
73014444224 10
===

I have all Power Management support (acpi/apm/cpu frequency code)
disabled is my linux kernel

cat /proc/version
Linux version 2.6.15.1 (root@atknoll6) (gcc version 3.3.6 (Ubuntu
1:3.3.6-8ubuntu1)) #13 SMP Wed May 17 20:13:33 CEST 2006


Thats the code snipplet, running in a kthread binded on CPU1, creating
the logs from above:

#define RDTSC(X) __asm__ __volatile__("rdtsc":"=A" (X))
[...]
 while (err < 10)
 {
    err++;
    i=1;
    /* bad hack, that CPU0 doesnt expect CPU1 to respond to anything */
    cpu_online_map = cpumask_of_cpu(0);
    local_irq_disable();
    RDTSC(ini);
/* some work which should need always the same time */
    while(i!=0)
    {
      i++; /* always +1 until we are overflowing */
      if(i==0)
      {
        j++;
      }
    }

    RDTSC(end);
    local_irq_enable();
    cpu_online_map = tmp_cpumask;
    now = end - ini;
    if (now > worst)
    {
      worst = now;
    }
    printk("New worst %lli %lli %i %i %i\n", worst,now, j,
           my_lug_test, my_lug_test2);

  }



This is my CPU:
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) D CPU 3.20GHz
stepping        : 4
cpu MHz         : 3192.671
cache size      : 1024 KB
[...]
which is a dual core CPU.

The full (very simple and i guess very ugly, because fast hack) module
code is uploaded here:
http://www.cip.physik.uni-muenchen.de/~fritzsch/tmp/module2.tar.gz

greetings & thx in advance for taking your time to read this and maybe
giving some advice.
patrick
