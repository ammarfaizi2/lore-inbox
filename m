Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbTF0XWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTF0XWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:22:38 -0400
Received: from aneto.able.es ([212.97.163.22]:27060 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264946AbTF0XWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:22:35 -0400
Date: Sat, 28 Jun 2003 01:36:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG?] do_generic_direct_write
Message-ID: <20030627233649.GC9706@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jun 27, 2003 at 00:03:02 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.27, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
> 

Correct me if I'm wrong. I found this just by chance:

mm/filemap.c:
ssize_t
do_generic_direct_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
...

    if (!file->f_flags & O_DIRECT)
        BUG();

This fails to trigger the BUG() just when it should. This should be:

    if (!(file->f_flags & O_DIRECT))
        BUG();

To check my C, I tried this:

#include <stdio.h>

#define O_D 2

int main()
{
    int flags;

    flags = O_D +4;
    printf("%d\n",!flags & O_D);
    printf("%d\n",!(flags & O_D));
    flags = 1+4;
    printf("%d\n",!flags & O_D);
    printf("%d\n",!(flags & O_D));

    return 0;
}

Output:

werewolf:~# ./kk
0
0
0
1

So it gives 0 when 'flags' != 0, not regarding if O_D is there or not....

Correct ?

One other job for the Stanford checker... ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
