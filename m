Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154446AbQBNPBc>; Mon, 14 Feb 2000 10:01:32 -0500
Received: by vger.rutgers.edu id <S154338AbQBNOSQ>; Mon, 14 Feb 2000 09:18:16 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:4991 "HELO ms2.inr.ac.ru") by vger.rutgers.edu with SMTP id <S154574AbQBNOJ6>; Mon, 14 Feb 2000 09:09:58 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200002141812.VAA02531@ms2.inr.ac.ru>
Subject: "softnet" drivers: an attempt to clarify
To: jgarzik@mandrakesoft.com, manfreds@colorfullife.com, davem@redhat.com (Dave Miller), alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.rutgers.edu
Date: Mon, 14 Feb 2000 21:12:23 +0300 (MSK)
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: owner-linux-kernel@vger.rutgers.edu

Hello!

The simplest way to convert driver:

1. dev->start = 1   -> nil
   dev->start = 0   -> nil
   (dev->start != 0)  -> test_bit(LINK_STATE_START, &dev->state)

   START flag is changed by top level, as it was proposed by Donald
   Becker. Namely, it is set after device is opened succesfully and
   cleared before closedown sequence is started.

   [ It is my mistake #1. All these things should be macros to keep source
     compatibility. I apologize, my vocabulary does not allow to generate
     such amount of macro names. 8) ]

2. All references to "dev->interrupt" are deleted. If someone feels that life
   is too boring without this flag, (s)he may use bit RXSEM or
   an internal device variable. Again, it was proposed by Donald.

3. dev->tbusy = 1   -> netif_stop_queue()
   dev->tbusy = 0   -> netif_wake_queue()
   [ The exception: if the device is not open yet, i.e. it is the first
     clearing tbusy in dev->open, macro netif_start_queue() should be used 
     instead. ]

   (dev->tbusy != 0) -> test_bit(LINK_STATE_XOFF, &dev->state)
   [ It is my mistake #2. This must be a macro. netif_queue_is_stopped()? ]

   mark_bh(NET_BH)  -> nil

4. Clause:
	 if (test_and_set_bit(0, &dev->tbusy))
		do_timeout_work;

  on entry to dev->hard_start_xmit() is replaced with netif_stop_queue()
  and do_timeout_work is moved to separate xxx_tx_timeout() routine,
  if it is already not there. All the drivers maintained by Donald have
  this work already done (it is also his idea).


====================================================================
That's all. Following this way you inevitably arrive to working
driver provided it worked in 2.2 and 2.3. If it still does not work,
diff it to base version and check, that you followed rules.
If you did, blame one me, curse me, kill me.
====================================================================


Common mistake, which I saw until now is using netif_start_queue().
Both Jamal's and Dave's docs say that dev->tbusy = 0 is equivalent
to netif_start_queue(). It is _TRUTH_. But it is not all the truth.
Safe replacement is dev->tbusy = 0  -> netif_wake_queue().
The reason of this is explain in that docs in words (earlier the
function made by netif_wake_queue() was made by dev_queue_xmit() upon
exit from dev->hard_start_xmit()), but it is not highlighten enough.

[ It is my mistake #3 and the worst one. It should be macro with name
  different of netif_wake_queue() to keep parallel with 2.2 and
  to allow some optimizations. ]


After the driver works second pass follows. Some drivers can be optimized.
The most common case is devices using controller spinlock.

If the device uses controller spinlock, you can delete netif_stop_queue()
(which replaced test_and_set_bit(tbusy) in turn) from preamble
and on exit from driver _before_ releasing spinlock you check
for condition opposite to netif_wake_queue() and make netif_stop_queue()
instead. See? If you do not raise XOFF strobe you need not to wake
up. It is impossible for lock-free devices, simply because they are
not lock-free really, but rather function of lock is entailed
to tbusy/XOFF.


About rtl8139 case. I falled in panic yesterday, but after looking
at its original source I found that panic had no base.
The race condition, which results inevitably to cleared tbusy while
ring is full and to corruption of tx ring is evident.
Just grep original source of tupip.c and rtl8139.c for tbusy and see
at difference. (Shortly, if hard_start_xmit() overlap to interrupt routine
state of tbusy is inpredictable.) I have no idea why it looked like
working earlier, the hole is evident, I falled to it hundred times
when hacking tulip. Look: tulip uses property that new elements to ring
are added only in hard_start_xmit(), which is not entered if tbusy is set.
So that interrupt routine does the following:

	if (dev->tbusy &&
	/* tbusy is set. Hence ring is frozen! */
	    we_have_some_free_slots())
		netif_wake_queue().

See? This genius trick is pretty suspicious (depends on memory write order),
but it works. rtl has not it, hence it cannot work.

Jeff tried to fix this adding some netif_stop_queue() to the driver,
this trick will not work. Then it will stay with stuck tbusy sometimes.

I think, it is easier to add controller spinlock to rtl than to repeat
fine tuning made by Donald f.e. for tulip.

Alexey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
