Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTKWBkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 20:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTKWBkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 20:40:25 -0500
Received: from main.gmane.org ([80.91.224.249]:43224 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263101AbTKWBkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 20:40:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David Wuertele <dave-gnus@bfnet.com>
Subject: Do I need kswapd if I don't have swap?
Date: Sat, 22 Nov 2003 17:35:57 -0800
Organization: Berkeley Fluent Network
Message-ID: <m3d6bj3lz6.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:lU7J2ZAa+MqK4T8DVZYcIzN7ZVU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.18 on my 32MB RAM embedded MIPS system, malloc() goes
bye-bye:

  /* Malloc as much as possible, then return */
  #include <stdio.h>
  #define UNIT 1024		/* one kilobyte */
  int main ()
  {
    unsigned int j, totalmalloc=0, totalwrote=0, totalread=0;
    while (1) {
      unsigned char *buf = (unsigned char *) malloc (UNIT);
      if (!buf) return 0;
      totalmalloc += UNIT; fprintf (stderr, "%u ", totalmalloc);
      for (j=0; j<UNIT; j++) buf[j] = j % 256;
      totalwrote += UNIT; fprintf (stderr, "%u ", totalwrote);
      for (j=0; j<UNIT; j++) if (buf[j] != (j % 256)) return -1;
      totalread += UNIT; fprintf (stderr, "%u\n", totalread);
    }
  }

I expected this program to malloc most of my embedded MIPS's 32MB of
system RAM, then eventually return with a -1 or a -2.  Unfortunately,
it hangs having finally printed:

  M26916864
  W26916864
  R26916864

The malloc call isn't even returning.  What could explain that?

I don't have swap space configured, and I notice several kernel
threads that I figure might be assuming I have swap.  For example:

      3 root     S    [ksoftirqd_CPU0]
      4 root     S    [kswapd]
      5 root     S    [bdflush]
      6 root     S    [kupdated]
      7 root     S    [mtdblockd]

Do I need any of these if I don't have swap?  Are there any special
kernel configs I should be doing if I don't have swap?

Thanks,
Dave

