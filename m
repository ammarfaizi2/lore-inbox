Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVDIDcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVDIDcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 23:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVDIDcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 23:32:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21165 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261264AbVDIDcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 23:32:19 -0400
Message-ID: <42574C88.9080601@engr.sgi.com>
Date: Fri, 08 Apr 2005 20:31:20 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>	<20050331144428.7bbb4b32.akpm@osdl.org>	<424C9177.1070404@engr.sgi.com>	<1112341968.9334.109.camel@uganda>	<4255B6D2.7050102@engr.sgi.com>	<4255B868.6040600@engr.sgi.com>	<1112955840.28858.236.camel@uganda>	<1112957563.28858.240.camel@uganda>	<4256E940.9050306@engr.sgi.com>	<425700CD.5040906@engr.sgi.com> <20050409021856.39e99bef@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050409021856.39e99bef@zanzibar.2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the patch you provide to me, i did not see the bugcheck
at cn_queue_wrapper() at the console.

Unmatched sequence number messages still happened. We expect
to lose packets under system stressed situation, but i still
observed duplicate messages, which concerned me.

Unmatched seq. Rcvd=79477, expected=79478	<=== duplicate
Unmatched seq. Rcvd=713823, expected=713422	* loss of 401 msgs
Unmatched seq. Rcvd=80024, expected=79901	* loss of 123 msgs

Unmatched seq. Rcvd=93632, expected=93633	<=== duplicate
Unmatched seq. Rcvd=94718, expected=93970
Unmatched seq. Rcvd=743576, expected=743502

Unmatched seq. Rcvd=123506, expected=123507	<=== duplicate
Unmatched seq. Rcvd=773753, expected=773503
Unmatched seq. Rcvd=124111, expected=123938

Unmatched seq. Rcvd=157172, expected=157173	<=== duplicate
Unmatched seq. Rcvd=813024, expected=812913	<=== duplicate
Unmatched seq. Rcvd=813024, expected=813025	<=== duplicate

Unmatched seq. Rcvd=157830, expected=157501
Unmatched seq. Rcvd=158408, expected=158145
Unmatched seq. Rcvd=813678, expected=813438

The test system was a two cpu ia64.

Thanks,
  - jay


Evgeniy Polyakov wrote:
> On Fri, 08 Apr 2005 15:08:13 -0700
> Jay Lan <jlan@engr.sgi.com> wrote:
> 
> 
>>Hi Evgeniy,
>>
>>Forget about my previous request of a new patch.
>>
>>The failures were straight forward enough to figure out.
> 
> 
> Ok.
> The latest sources are always awailable at
> http://tservice.net.ru/~s0mbre/archive/connector
> 
> 
>>- jay
>>
>>Jay Lan wrote:
>>
>>>My workarea was based on 2.6.12-rc1-mm4 plus Guilluame's patch.
>>>
>>>Your patch caused 5 out of 8 hunks failure at connector.c
>>>and one failure at connector.h.
>>>
>>>Could you generate a new patch based on my version? A tar
>>>file of complete source of drivers/connector would work
>>>also. :)
>>>
>>>Thanks!
>>> - jay
>>>
>>>Evgeniy Polyakov wrote:
>>>
>>>
>>>>Could you give attached patch a try instead of previous one.
>>>>It adds gfp mask into cn_netlink_send() call also.
>>>>If you need updated CBUS sources, feel free to ask, I will send 
>>>>updated sources with Andrew's comments resolved too.
>>>>
>>>>I do not know exactly your connector version, so patch will probably 
>>>>be applied with fuzz.
>>>>
>>>>feel free to contact if it does not apply, I will send
>>>>the whole sources.
>>>>
>>>>Thank you.
>>>>
>>>>* looking for johnpol@2ka.mipt.ru-2004/connector--main--0--patch-38 to 
>>>>compare with
>>>>* comparing to johnpol@2ka.mipt.ru-2004/connector--main--0--patch-38
>>>>M  connector.c
>>>>M  connector.h
>>>>M  cbus.c
>>>>
>>>>* modified files
>>>>
>>>>--- orig/drivers/connector/connector.c
>>>>+++ mod/drivers/connector/connector.c
>>>>@@ -70,7 +70,7 @@
>>>>  * then it is new message.
>>>>  *
>>>>  */
>>>>-void cn_netlink_send(struct cn_msg *msg, u32 __groups)
>>>>+void cn_netlink_send(struct cn_msg *msg, u32 __groups, int gfp_mask)
>>>> {
>>>>     struct cn_callback_entry *n, *__cbq;
>>>>     unsigned int size;
>>>>@@ -102,7 +102,7 @@
>>>> 
>>>>     size = NLMSG_SPACE(sizeof(*msg) + msg->len);
>>>> 
>>>>-    skb = alloc_skb(size, GFP_ATOMIC);
>>>>+    skb = alloc_skb(size, gfp_mask);
>>>>     if (!skb) {
>>>>         printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", 
>>>>size);
>>>>         return;
>>>>@@ -119,11 +119,11 @@
>>>> #endif
>>>>    
>>>>     NETLINK_CB(skb).dst_groups = groups;
>>>>-
>>>>-    uskb = skb_clone(skb, GFP_ATOMIC);
>>>>-    if (uskb)
>>>>+#if 0
>>>>+    uskb = skb_clone(skb, gfp_mask);
>>>>+    if (uskb && 0)
>>>>         netlink_unicast(dev->nls, uskb, 0, 0);
>>>>-   
>>>>+#endif   
>>>>     netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
>>>> 
>>>>     return;
>>>>@@ -158,7 +158,7 @@
>>>>     }
>>>>     spin_unlock_bh(&dev->cbdev->queue_lock);
>>>> 
>>>>-    return found;
>>>>+    return (found)?0:-ENODEV;
>>>> }
>>>> 
>>>> /*
>>>>@@ -181,7 +181,6 @@
>>>>                 "requested msg->len=%u[%u], nlh->nlmsg_len=%u, 
>>>>skb->len=%u.\n",
>>>>                 msg->len, NLMSG_SPACE(msg->len + sizeof(*msg)),
>>>>                 nlh->nlmsg_len, skb->len);
>>>>-        kfree_skb(skb);
>>>>         return -EINVAL;
>>>>     }
>>>> #if 0
>>>>@@ -215,17 +214,18 @@
>>>>            skb->len, skb->data_len, skb->truesize, skb->protocol,
>>>>            skb_cloned(skb), skb_shared(skb));
>>>> #endif
>>>>-    while (skb->len >= NLMSG_SPACE(0)) {
>>>>+    if (skb->len >= NLMSG_SPACE(0)) {
>>>>         nlh = (struct nlmsghdr *)skb->data;
>>>>+
>>>>         if (nlh->nlmsg_len < sizeof(struct cn_msg) ||
>>>>             skb->len < nlh->nlmsg_len ||
>>>>             nlh->nlmsg_len > CONNECTOR_MAX_MSG_SIZE) {
>>>>-#if 0
>>>>+#if 1
>>>>             printk(KERN_INFO "nlmsg_len=%u, sizeof(*nlh)=%u\n",
>>>>                    nlh->nlmsg_len, sizeof(*nlh));
>>>> #endif
>>>>             kfree_skb(skb);
>>>>-            break;
>>>>+            goto out;
>>>>         }
>>>> 
>>>>         len = NLMSG_ALIGN(nlh->nlmsg_len);
>>>>@@ -233,22 +233,11 @@
>>>>             len = skb->len;
>>>> 
>>>>         err = __cn_rx_skb(skb, nlh);
>>>>-        if (err) {
>>>>-#if 0
>>>>-            if (err < 0 && (nlh->nlmsg_flags & NLM_F_ACK))
>>>>-                netlink_ack(skb, nlh, -err);
>>>>-#endif
>>>>-            break;
>>>>-        } else {
>>>>-#if 0
>>>>-            if (nlh->nlmsg_flags & NLM_F_ACK)
>>>>-                netlink_ack(skb, nlh, 0);
>>>>-#endif
>>>>-            break;
>>>>-        }
>>>>-        skb_pull(skb, len);
>>>>+        if (err < 0)
>>>>+            kfree_skb(skb);
>>>>     }
>>>>-           
>>>>+
>>>>+out:
>>>>     kfree_skb(__skb);
>>>> }
>>>> 
>>>>@@ -310,7 +299,7 @@
>>>>             m.ack = notify_event;
>>>> 
>>>>             memcpy(&m.id, id, sizeof(m.id));
>>>>-            cn_netlink_send(&m, ctl->group);
>>>>+            cn_netlink_send(&m, ctl->group, GFP_ATOMIC);
>>>>         }
>>>>     }
>>>>     spin_unlock_bh(&notify_lock);
>>>>
>>>>
>>>>--- orig/include/linux/connector.h
>>>>+++ mod/include/linux/connector.h
>>>>@@ -148,7 +148,7 @@
>>>> 
>>>> int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
>>>> void cn_del_callback(struct cb_id *);
>>>>-void cn_netlink_send(struct cn_msg *, u32);
>>>>+void cn_netlink_send(struct cn_msg *, u32, int);
>>>> 
>>>> int cn_queue_add_callback(struct cn_queue_dev *dev, struct 
>>>>cn_callback *cb);
>>>> void cn_queue_del_callback(struct cn_queue_dev *dev, struct cb_id *id);
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
> 
> 
> 	Evgeniy Polyakov
> 
> Only failure makes us experts. -- Theo de Raadt

