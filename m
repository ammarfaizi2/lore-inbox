Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276782AbRJUVTU>; Sun, 21 Oct 2001 17:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276786AbRJUVTB>; Sun, 21 Oct 2001 17:19:01 -0400
Received: from server.igoweb.org ([207.173.200.73]:18123 "HELO
	server.igoweb.org") by vger.kernel.org with SMTP id <S276782AbRJUVSz>;
	Sun, 21 Oct 2001 17:18:55 -0400
Message-ID: <3BD33BDD.4010703@igoweb.org>
Date: Sun, 21 Oct 2001 14:19:25 -0700
From: "William M. Shubert" <wms@igoweb.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-US, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Method to "unstick" buggy raid1 devices
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once I found out why my "dd" program was stuck, and what the workaround 
was, it was easy to see that no reboot was necessary to fix the problem. 
If you can easily reboot with a new kernel that doesn't have this bug, 
then of course that is the best solution, but for irritating reasons 
rebooting would have been difficult for me. If anybody else ever has the 
same problem, here is a reboot-less fix. It wasn't hard to write - I 
just tested it on a crashable system, it worked, so I installed it on my 
production system that was suffering from a frozen "dd" process.

When you need this: If you have a system running a kernel with a buggy 
raid1 driver and you can't easily switch to a non-buggy kernel. Vanilla 
2.4.9 is buggy. Red hat 2.4.9 is not. I do not know which other kernels 
are/are not buggy. If you get hit with the bug, the symptom will be that 
one or more programs is "frozen", can't be killed, and never does 
anything. If you check the "wchan" parameter of "top" or "ps", it is 
stuck in "raid1_alloc_r1bh". This will happen very rarely - only if a 
process is doing a disk write at the exact moment that the system is 
temporarily out of physical memory. If your system is under heavy load 
it will happen much more often.

After you apply the bug, once per minute this module will wake up, look 
for stuck raid devices, and "unstick" them if necessary. So at most your 
processes will freeze for 1 minute. You can also make it check more 
often if you want.

Not sure if anybody but me will need it, but just in case - here it is!

#define __KERNEL__ 1
#define MODULE 1

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kdev_t.h>
#include <linux/raid/md.h>
#include <linux/raid/md_k.h>
#include <linux/raid/raid1.h>

static struct timer_list timer;

#define CHECK_INTERVAL (60 * HZ) /* Once per minute. */
#define NUM_RAIDS 3 /* # of raid1 partitions. Make sure this is correct! */

static void doFix(unsigned long x) {
  int i;
  raid1_conf_t *conf;
  for (i = 0; i < NUM_RAIDS; ++i) {
    conf = mddev_to_conf(kdev_to_mddev(MKDEV(9, i)));
    if (conf->freer1_blocked == 1) {
      printk(KERN_WARNING "fixRaid: MD system %d is stuck. Fixing.\n", i);
      conf->freer1_blocked = 0;
      wake_up(&conf->wait_buffer);
    }
  }
  timer.expires = jiffies + CHECK_INTERVAL;
  add_timer(&timer);
}

int fixRaid_init(void) {
  init_timer(&timer);
  timer.expires = jiffies + CHECK_INTERVAL;
  timer.data = 0;
  timer.function = &doFix;
  add_timer(&timer);
  return(0);
}

void fixRaid_cleanup(void) {
  del_timer(&timer);
}

module_init(fixRaid_init);
module_exit(fixRaid_cleanup);
-- 

Bill Shubert (wms@igoweb.org) <mailto:wms@igoweb.org>
http://www.igoweb.org/~wms/ <http://igoweb.org/%7Ewms/>


