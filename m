Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbUKIXRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUKIXRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUKIXRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:17:36 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:47818 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261734AbUKIXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:16:20 -0500
Message-ID: <419154F9.7070000@drdos.com>
Date: Tue, 09 Nov 2004 16:38:33 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 RCU breakage in dev_queue_xmit
References: <4190FFE9.8000203@drdos.com>	<419108ED.9090608@trash.net>	<41910F1A.8070305@drdos.com> <20041109103732.6422f138@zqx3.pdx.osdl.net>
In-Reply-To: <20041109103732.6422f138@zqx3.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------090004090508030303050905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090004090508030303050905
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:

>On Tue, 09 Nov 2004 11:40:26 -0700
>"Jeff V. Merkey" <jmerkey@drdos.com> wrote:
>
>  
>
>>Patrick McHardy wrote:
>>
>>    
>>
>>>Jeff V. Merkey wrote:
>>>
>>>      
>>>
>>>>Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
>>>>receive, 12 CLK interacket gap time, 1500 bytes payload
>>>>at 65000 packets per second per gigabit interface, and retransmitting 
>>>>received packets at 130 MB/S out of a third gigabit interface
>>>>with skb, RCU locks in dev_queue_xmit breaks and enters the following 
>>>>state:
>>>>
>>>>Nov  8 15:38:08 ds kernel: Badness in local_bh_enable at 
>>>>kernel/softirq.c:141
>>>>Nov  8 15:38:08 ds kernel:  [<40107d1e>] dump_stack+0x1e/0x30
>>>>Nov  8 15:38:08 ds kernel:  [<401218b0>] local_bh_enable+0x70/0x80
>>>>Nov  8 15:38:08 ds kernel:  [<402c5bbb>] dev_queue_xmit+0x11b/0x250
>>>>Nov  8 15:38:08 ds kernel:  [<f8981cb7>] xmit_skb+0x17/0x20 [dsfs]
>>>>Nov  8 15:38:08 ds kernel:  [<f8981f8e>] xmit_packet+0x2e/0x80 [dsfs]
>>>>Nov  8 15:38:08 ds kernel:  [<f89820eb>] regen_data+0x10b/0x290 [dsfs]
>>>>        
>>>>
>>>There is no such function in the 2.6.9 kernel.
>>>      
>>>
>>Check /include/linux for local_bh_enable and /net/core/dev.c .
>>
>>Jeff
>>
>>    
>>
>>>Regards
>>>Patrick
>>>      
>>>
>
>Patrick is asking about the function regen_data which doesn't exist in the
>standard kernel.
>-
>
>  
>

Code for regen_data cuntion attached. This code provides the example of 
the calls into linux that cause
the RCU locks to fail in dev_queue_xmit. The remainder of this module is 
not open source and
proprietary.

Jeff






--------------090004090508030303050905
Content-Type: text/x-csrc;
 name="regen.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regen.c"


int regen_active = 0;
int kill_regen = 0;
int regen_pid = 0;
unsigned long dsfs_skb_count = 0;

static void p_timeout(unsigned long data)
{
   SignalSemaphore((struct semaphore *)data);
}

int pm_sleep(int ticks)
{
   struct timer_list l_timer;
   register int retCode;
   P_InitSemaphore(semaphore);

   if (!seconds)
      return 0;

   init_timer(&l_timer);
   l_timer.expires = jiffies + ((HZ / 100) * ticks); 
   l_timer.data = (unsigned long)&semaphore;
   l_timer.function = p_timeout;

   add_timer(&l_timer);
   retCode = down_interruptible(&semaphore);
   del_timer(&l_timer);

   return ((retCode == -EINTR) ? -EINTR : 0);

}

int xmit_skb(struct sk_buff *skb)
{
   dsfs_skb_count--;
   return (dev_queue_xmit(skb));
}

void release_skb(struct sk_buff *skb)
{
   dsfs_skb_count--;
   kfree_skb(skb);
}

struct sk_buff *create_xmit_packet(int interface, int *err, int *skb_len)
{
	struct sk_buff *skb;
	struct net_device *dev;

        if (err)
           *err = 0;

        if (skb_len)
           *skb_len = 0;

	dev = dev_get_by_index(interface);
	if (!dev)
        {
           if (err)
              *err = -ENXIO;
           return NULL;
        }

	if (!(dev->flags & IFF_UP))
        {
	   dev_put(dev);
           if (err)
              *err = -ENETDOWN;
           return NULL;
        }

        skb = alloc_skb(dev->mtu + dev->hard_header_len + 15, GFP_ATOMIC);
        if (!skb)
        {
	   dev_put(dev);
           if (err)
              *err = -ENOBUFS;
           return NULL;
        }
        dsfs_skb_count++;

	skb_reserve(skb, (dev->hard_header_len + 15) & ~15);
	skb->nh.raw = skb->data;
        if (skb_len)
           *skb_len = (dev->mtu + dev->hard_header_len + 4);

	skb->dev = dev;

	dev_put(dev);
        return skb;

}

struct vlan_ethhdr 
{
   unsigned char	h_dest[6];     /* destination eth addr	*/
   unsigned char	h_source[6];   /* source ether addr	*/
   unsigned short       h_vlan_proto;  /* Should always be 0x8100 */
   unsigned short       h_vlan_TCI;    /* Encapsulates priority and VLAN ID */
   unsigned short	h_vlan_encapsulated_proto; /* packet type ID field (or len) */
};

void put_xmit_data(struct sk_buff *skb, unsigned char *data, int len, 
                   int proto, P_HANDLE *p_handle)
{
        struct vlan_ethhdr *vlan;

        if (skb->dev->hard_header) 
           skb->dev->hard_header(skb, skb->dev, ntohs(proto), 
                                 NULL, NULL, len);

        skb->tail = skb->data;
        skb->len = 0;

        // strip vlan headers if told to do so
        vlan = (struct vlan_ethhdr *)data;
        if ((p_handle->xmit_flags & STRIP_VLAN)
            && (ntohs(vlan->h_vlan_proto) == 0x8100))
        {
           memmove(skb->data, data, 12); 
           memmove(&skb->data[12], &data[16], len - 16); 
           skb_put(skb, len - 4);
        }
        else
        {
           memmove(skb->data, data, len); 
           skb_put(skb, len);
        }
        skb->protocol = proto;

        return;
}

int xmit_packet(struct sk_buff *skb)
{
	struct net_device *dev;
	int err;

	dev = dev_get_by_index(skb->dev->ifindex);
	if (!dev)
        {
           release_skb(skb);
	   return -ENXIO;
        }

	if (!(dev->flags & IFF_UP))
        {
	   dev_put(dev);
           release_skb(skb);
	   return -ENETDOWN;
        }

	skb->priority = 0;  // 0-6 set to 0

	err = xmit_skb(skb);
	if (err > 0 && (err = net_xmit_errno(err)) != 0)
        {
	   dev_put(dev);
           return err;
        }
	dev_put(dev);

	return 0;
}

int regen_data(void *arg)
{
    register ULONG pindex;
    struct sk_buff *skb;
    long long size;
    int err, skb_len;
    ULONG length = 0;
    VIRTUAL_SETUP *v = (VIRTUAL_SETUP *)arg;
    P_HANDLE *p_handle;

#if LINUX_26
    daemonize("if_regen%d", (int)v->pid);
#else
    sprintf(current->comm, "if_regen%d", (int)v->pid);
    daemonize();
#endif

    regen_active++;
    v->active++;
    while (v->ctl)
    {
retry:;
       if (v->interval)
       { 
#if LINUX_26
          v->currtime = CURRENT_TIME.tv_sec;
#else
          v->currtime = CURRENT_TIME;
#endif
          if (v->lasttime == v->currtime)
          {
             if (v->totalbytes >= (v->interval * (1000000 / 8)))
             {
                pi_sleep(1);
                goto retry; 
             }
          }
       }

       if (kill_regen)
          break;

       skb = create_xmit_packet(v->pindex, &err, &skb_len);
       if (!skb)
       {      
          switch (err)
          {
              case -ENXIO:
                 v->retry_errors++;
                 v->interface_errors++;
                 if (!pm_sleep(VIRTUAL_SLEEP))
                    goto retry;
                 goto exit_process;

              case -ENETDOWN:
                 v->interface_errors++;
                 v->retry_errors++;
                 if (!pm_sleep(VIRTUAL_SLEEP))
                    goto retry;
                 goto exit_process;

              case -EMSGSIZE:
                 v->size_errors++;
                 v->retry_errors++;
                 if (!pm_sleep(VIRTUAL_SLEEP))
                    goto retry;
                 goto exit_process;

              case -EINVAL:
                 v->fault_errors++;
                 v->retry_errors++;
                 if (!pm_sleep(VIRTUAL_SLEEP))
                    goto retry;
                 goto exit_process;

              case -ENOBUFS:
                 v->no_buffer_errors++;
                 v->retry_errors++;
                 if (!pm_sleep(VIRTUAL_SLEEP))
                    goto retry;
                 goto exit_process;

              default:
                 v->fault_errors++;
                 v->retry_errors++;
                 if (!pm_sleep(VIRTUAL_SLEEP))
                    goto retry;
                 goto exit_process;
          }
       }

read_again:;
       if ((kill_regen) || (!v->ctl))
       {
          release_skb(skb);
          goto exit_process;
       }

       p_handle = v->p_handle;
       if (!p_handle)
       {
          release_skb(skb);
          goto exit_process;
       }


       // this is the function that copies data into the skb
       // via copy_to_iovec
       pindex = regen_chain_packet(v->interface, skb, skb_len, p_handle, 
                                   &length, NULL, NULL, 
                                   &p_handle->start, &p_handle->end,
                                   v->d);

       if (pindex == -ENOENT)
       {
          release_skb(skb);
          goto exit_process;
       }

       if (pindex == 0xFFFFFFFF)
       {
          if (!pm_sleep(VIRTUAL_SLEEP))
             goto read_again;
          release_skb(skb);
          goto exit_process;
       }

       if (!length)
       {
          if (!pm_sleep(VIRTUAL_SLEEP))
             goto read_again;
          release_skb(skb);
          goto exit_process;
       }
   
       size = skb->len;

       err = xmit_packet(skb);
       if (err)
       {
          v->packets_aborted++;
       }
       else
       {
          v->bytes_xmit += size;
          v->packets_xmit++;
       }

       if (v->interval)
       {
#if LINUX_26
          v->currtime = CURRENT_TIME.tv_sec;
#else
          v->currtime = CURRENT_TIME;
#endif
          if (v->lasttime != v->currtime)
             v->totalbytes = 0;

          v->totalbytes += size;
          v->lasttime = v->currtime;
       }
    }

exit_process:;
    v->active--;
    regen_active--;

    return 0;

}


--------------090004090508030303050905--
