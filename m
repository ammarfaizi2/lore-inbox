Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752135AbWCNDc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbWCNDc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWCNDc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:32:27 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:2494 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752135AbWCNDc1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:32:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qGqNxugbyJ3I5QguX3THnm01KD5R2YZAYQw4mhereslRX5lAIJegl8wx++HHIm4zzyjsOff5FvuWzHyCq1fnvrMJ8DtoXAilv16TvxhBa9AVo8hEIt+3wFzmkM/rYWtuIzu+BQ0XHSHn35/3YZR1+IAPRyQl+PAtFYzfIrQItS4=
Message-ID: <661de9470603131932h7ff99aacgde3911ae82b77dc8@mail.gmail.com>
Date: Tue, 14 Mar 2006 09:02:25 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
Cc: "Nick Piggin" <npiggin@suse.de>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
In-Reply-To: <4415F410.90706@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207021822.10002.30448.sendpatchset@linux.site>
	 <20060207021831.10002.84268.sendpatchset@linux.site>
	 <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>
	 <44128EDA.6010105@yahoo.com.au>
	 <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
	 <4414E2CB.7060604@yahoo.com.au>
	 <661de9470603130724mc95405dr6ee32d00d800d37@mail.gmail.com>
	 <4415F410.90706@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "slots" member is an array, not an RCU assigned pointer. As such, after
> doing rcu_dereference(slot), you can access slot->slots[i] without further
> memory barriers I think?
>
> But I agree that code now is a bit inconsistent. I've cleaned things up a
> bit in my tree now... but perhaps it is easier if you send a patch to show
> what you mean (because sometimes I'm a bit dense, I'm afraid).
>

Fro starters, I do not think your dense at all.

Hmm... slot/slots is quite confusing name. I was referring to slot and
ended up calling it slots. The point I am contending is that
rcu_derefence(slot->slots[i]) should happen.

<snippet>
+                       __s = rcu_dereference(slot->slots[i]);
+                       if (__s != NULL)
                              break;
</snippet>

If we break from the loop because __s != NULL. Then in the snippet below

<snippet>
       /* Bottom level: grab some items */
      for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
              index++;
              if (slot->slots[i]) {
-                       results[nr_found++] = slot->slots[i];
+                       results[nr_found++] = &slot->slots[i];
                      if (nr_found == max_items)
                              goto out;
              }
</snippet>

We do not use __s above. "slot->slots[i]" is not rcu_derefenced() in
this case because we broke out of the loop above with __s being not
NULL. Another issue is - is it good enough to rcu_derefence() slot
once? Shouldn't all uses of *slot->* be rcu derefenced?

<suggestion (WARNING: patch has spaces and its not compiled)>
       /* Bottom level: grab some items */
      for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
              index++;
-              if (slot->slots[i]) {
-                       results[nr_found++] = slot->slots[i];
+             __s = rcu_dereference(slot->slots[i]);
+             if (__s) {
+                    /* This is tricky, cannot take the address of __s
or rcu_derefence() */
+                    results[nr_found++] = &slot->slots[i];
                      if (nr_found == max_items)
                              goto out;
              }
</suggestion>

I hope I am making sense.

Warm Regards,
Balbir
