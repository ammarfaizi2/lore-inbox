Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135628AbREBQSl>; Wed, 2 May 2001 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135625AbREBQSe>; Wed, 2 May 2001 12:18:34 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40012 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S135628AbREBQSO>; Wed, 2 May 2001 12:18:14 -0400
Message-ID: <3AF032D2.51D61EF4@sgi.com>
Date: Wed, 02 May 2001 09:16:18 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 code breaks compile of VMWare network bridging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.4, the define, in
    include/linux/skbuff.h
and corresponding structure in
    net/core/skbuff.c
, "skb_datarefp" disappeared.

I'm not reporting this as a 'bug' as kernel internal interfaces are subject
to change, but more as an "FYI".  I haven't had a chance to try to
debug or figure out the offending bit of code to see exactly what it
was trying to do, but the offending code snippet follows.  I haven't yet
reported it to the folks at VMware, but their response to problem reports
against 2.4.x is "can you duplicate it against 2.2.x, we don't support
2.4.x yet".  Perhaps someone expert in the 'net/core' area could explain
what changed and what they shouldn't be doing anymore?

It appears the references:
#  define KFREE_SKB(skb, type)          kfree_skb(skb)
#  define DEV_KFREE_SKB(skb, type)      dev_kfree_skb(skb)
                                        ^^^^^^^^^^^^^^^^^^
are the offending culprits.

Thanks for any insights...
-linda

/*
 *----------------------------------------------------------------------
 * VNetBridgeReceiveFromDev --
 *      Receive a packet from a bridged peer device
 *      This is called from the bottom half.  Must be careful.
 * Results:
 *      errno.
 * Side effects:
 *      A packet may be sent to the vnet.
 *----------------------------------------------------------------------
 */
int
VNetBridgeReceiveFromDev(struct sk_buff *skb,
                         struct device *dev,
                         struct packet_type *pt)
{
   VNetBridge *bridge = *(VNetBridge**)&((struct sock *)pt->data)->protinfo;
   int i;

   if (bridge->dev == NULL) {
      LOG(3, (KERN_DEBUG "bridge-%s: received %d closed\n",
              bridge->name, (int) skb->len));
      DEV_KFREE_SKB(skb, FREE_READ);
      return -EIO;      // value is ignored anyway
   }

   // XXX need to lock history
   for (i = 0; i < VNET_BRIDGE_HISTORY; i++) {
      struct sk_buff *s = bridge->history[i];
      if (s != NULL &&
          (s == skb || SKB_IS_CLONE_OF(skb, s))) {
         bridge->history[i] = NULL;
         KFREE_SKB(s, FREE_WRITE);
         LOG(3, (KERN_DEBUG "bridge-%s: receive %d self %d\n",
                 bridge->name, (int) skb->len, i));
         // FREE_WRITE because we did the allocation, it's not used anyway
         DEV_KFREE_SKB(skb, FREE_WRITE);
         return 0;
      }
   }
   skb_push(skb, skb->data - skb->mac.raw);
   VNetSend(&bridge->port.jack, skb);

   return 0;
}

--
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338


