Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293258AbSCKVuw>; Mon, 11 Mar 2002 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293285AbSCKVut>; Mon, 11 Mar 2002 16:50:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293258AbSCKVu3>;
	Mon, 11 Mar 2002 16:50:29 -0500
Message-ID: <3C8D2693.9000801@mandrakesoft.com>
Date: Mon, 11 Mar 2002 16:50:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.6] New wireless driver API part 2
In-Reply-To: <20020311115523.A10682@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:

>+
>+/* ---------------------------------------------------------------- */
>+/*
>+ * Main event dispatcher. Called from other parts and drivers.
>+ * Send the event on the apropriate channels.
>+ * May be called from interrupt context.
>+ */
>+void wireless_send_event(struct net_device *	dev,
>+			 unsigned int		cmd,
>+			 union iwreq_data *	wrqu,
>+			 char *			extra)
>+{
>+	const struct iw_ioctl_description *	descr = NULL;
>+	int extra_len = 0;
>+	struct iw_event  *event;		/* Mallocated whole event */
>+	int event_len;				/* Its size */
>+	int hdr_len;				/* Size of the event header */
>+	/* Don't "optimise" the following variable, it will crash */
>+	unsigned	cmd_index;		/* *MUST* be unsigned */
>+
>+	/* Get the description of the IOCTL */
>+	if(cmd <= SIOCIWLAST) {
>+		cmd_index = cmd - SIOCIWFIRST;
>+		if(cmd_index < standard_ioctl_num)
>+			descr = &(standard_ioctl[cmd_index]);
>+	} else {
>+		cmd_index = cmd - IWEVFIRST;
>+		if(cmd_index < standard_event_num)
>+			descr = &(standard_event[cmd_index]);
>+	}
>+	/* Don't accept unknown events */
>+	if(descr == NULL) {
>+		/* Note : we don't return an error to the driver, because
>+		 * the driver would not know what to do about it. It can't
>+		 * return an error to the user, because the event is not
>+		 * initiated by a user request.
>+		 * The best the driver could do is to log an error message.
>+		 * We will do it ourselves instead...
>+		 */
>+	  	printk(KERN_ERR "%s (WE) : Invalid Wireless Event (0x%04X)\n",
>+		       dev->name, cmd);
>+		return;
>+	}
>+#ifdef WE_EVENT_DEBUG
>+	printk(KERN_DEBUG "%s (WE) : Got event 0x%04X\n",
>+	       dev->name, cmd);
>+	printk(KERN_DEBUG "%s (WE) : Header type : %d, Token type : %d, size : %d, token : %d\n", dev->name, descr->header_type, descr->token_type, descr->token_size, descr->max_tokens);
>+#endif	/* WE_EVENT_DEBUG */
>+
>+	/* Check extra parameters and set extra_len */
>+	if(descr->header_type == IW_HEADER_TYPE_POINT) {
>+		/* Check if number of token fits within bounds */
>+		if(wrqu->data.length > descr->max_tokens) {
>+		  	printk(KERN_ERR "%s (WE) : Wireless Event too big (%d)\n", dev->name, wrqu->data.length);
>+			return;
>+		}
>+		if(wrqu->data.length < descr->min_tokens) {
>+		  	printk(KERN_ERR "%s (WE) : Wireless Event too small (%d)\n", dev->name, wrqu->data.length);
>+			return;
>+		}
>+		/* Calculate extra_len - extra is NULL for restricted events */
>+		if(extra != NULL)
>+			extra_len = wrqu->data.length * descr->token_size;
>+#ifdef WE_EVENT_DEBUG
>+		printk(KERN_DEBUG "%s (WE) : Event 0x%04X, tokens %d, extra_len %d\n", dev->name, cmd, wrqu->data.length, extra_len);
>+#endif	/* WE_EVENT_DEBUG */
>+	}
>+
>+	/* Total length of the event */
>+	hdr_len = event_type_size[descr->header_type];
>+	event_len = hdr_len + extra_len;
>+
>+#ifdef WE_EVENT_DEBUG
>+	printk(KERN_DEBUG "%s (WE) : Event 0x%04X, hdr_len %d, event_len %d\n", dev->name, cmd, hdr_len, event_len);
>+#endif	/* WE_EVENT_DEBUG */
>+
>+	/* Create temporary buffer to hold the event */
>+	event = kmalloc(event_len, GFP_ATOMIC);
>+	if(event == NULL)
>+		return;
>+
>+	/* Fill event */
>+	event->len = event_len;
>+	event->cmd = cmd;
>+	memcpy(&event->u, wrqu, hdr_len - IW_EV_LCP_LEN);
>+	if(extra != NULL)
>+		memcpy(((char *) event) + hdr_len, extra, extra_len);
>+
>+#ifdef WE_EVENT_NETLINK
>+	/* rtnetlink event channel */
>+	rtmsg_iwinfo(dev, (char *) event, event_len);
>+#endif	/* WE_EVENT_NETLINK */
>+
>+	/* Cleanup */
>+	kfree(event);
>+
>+	return;		/* Always success, I guess ;-) */
> }
>
>

Overall looks good.  My only minor objection would be that this function 
should return an error value.  Clearly the kmalloc can fail, at least.

    Jeff




