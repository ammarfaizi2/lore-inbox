Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266390AbUAIAfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUAIAfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:35:47 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:21226 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S266390AbUAIAfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:35:24 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Thu, 8 Jan 2004 16:35:22 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: spin_lock() and smp/multicall logic
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040109003522.F1411E4B9@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As always, CC all replies back to me.

I'm looking at include/linux/spinlock.h and I'm incredibly confused on something.

The logic I've come up with to make a function that is 100% impossible to execute
twice at once, even if it gets called on 2 processors in perfect parallel, is:

int run_me_once_at_once() {
  static int skip_out = 0; /*0 the first time*/
  int retval;
start_check:
  if (skip_out)
    return -EBUSY; /*busy*/
  skip_out++;
  if (skip_out != 1) { /*okay, somehow we must be in perfec parallel*/
    retval = -EBUSY;/*so undo OUR skip_out++ and return the busy signal*/
    goto out;
  }

  retval = 0; /*success!*/
out:
  skip_out--;
  return retval;
}

In basic terms, if there's an infinite number of processes executing this in
perfect parallel, then in the worst case every one of them will realize this and
return an -EBUSY error.  If one is far enough behind all of the others that they
all get to their respective skip_out-- calls before it gets its relavent check,
then that ONE will execute.

Now, if you want to wait until the function is free instead of returning an erorr,
then you will need to decriment your skip_out and goto start_check, then wait.
Here would be my logic for that:

int run_me_once_at_once() {
  static int skip_out = 0; /*0 the first time*/
  int retval;
  int rwait = 1; /*hold-down timer count*/
start_check:
  do { /*hold-down timer*/
  } while(--rwait);

  while (skip_out) { /*busy, just idle for a while.*/
  }

  skip_out++; /*okay, try now*/
  if (skip_out != 1) { /*okay, somehow we must be in perfec parallel*/
    skip_out--; /*so undo OUR skip_out++*/
    rwait = get_random_int(); /*random hold-down timer to break parallelism*/
    goto start_check; /*and go wait and try again*/
  }

  retval = 0; /*success!*/
out:
  skip_out--;
  return retval;
}

I don't understand anything about SMP or spin_lock(), but for some applications at
least, you can protect a function from parallel calls like this.


SO the two questions I'd like to address here are:

1) What is the purpose of spin_lock()
2) Am I the first person to come up with this method of non-parallel execution
  guarentee?

just wondering.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
