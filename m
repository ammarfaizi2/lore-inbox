Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTFLWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbTFLWN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:13:57 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:60900 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264835AbTFLWNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:13:54 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Steven Dake <sdake@mvista.com>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Date: Fri, 13 Jun 2003 00:27:09 +0200
User-Agent: KMail/1.5.1
References: <3EE8D038.7090600@mvista.com>
In-Reply-To: <3EE8D038.7090600@mvista.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306130027.09288.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If it works for you or doesn't or you like the idea or don't, I've love
> to hear about it

+	default:
+		result = -EINVAL;
+		break;
+	}
+	return (result);

Must return ENOTTY.

+static int sdeq_open (struct inode *inode, struct file *file)
+{
+	MOD_INC_USE_COUNT;
+
+	return 0;
+}
+
+static int sdeq_release (struct inode *inode, struct file *file)
+{
+	MOD_DEC_USE_COUNT;
+
+	return (0);
+}

Wrong. release does not map to close()


Aside from that, what exactly are you trying to do?
You are not solving the fundamental device node reuse race,
yet you are making necessary a further demon.
You are not addressing queue limits. The current hotplug
scheme does so, admittedly crudely by failing to spawn
a task, but considering the small numbers of events in
question here, for the time being we can live with that.

You can just as well add load control and error detection
to the current scheme. You fail to do so in your scheme.
You cannot queue events forever in unlimited numbers.

As for ordering, this is a real problem, but not fundamental.
You can make user space locking work. IMHO it will not be
pretty if done with shell scripts, but it can work.
There _is_ a basic problem with the kernel 'overtaking'
user space in its view of the device tree, but you cannot solve
that _at_ _all_ in user space.

In short, if you feel that the hotplug scheme is inadequate
for your needs, then write industry strength devfs2.

	Regards
		Oliver

