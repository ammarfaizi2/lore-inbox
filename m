Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUJUJRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUJUJRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbUJUJL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:11:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30985 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270517AbUJUJJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:09:17 -0400
Date: Thu, 21 Oct 2004 10:09:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Am I paranoid or is everyone out to break my kernel builds (Breakage in drivers/pcmcia)
Message-ID: <20041021100903.A3089@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would appear that this change:

-module_param_array(irq_list, int, irq_list_count, 0444);
+module_param_array(irq_list, int, &irq_list_count, 0444);

given:

static int irq_list[16];
static int irq_list_count;

breaks PCMCIA drivers.  Why?

#define module_param_array(name, type, num, perm)               \
        module_param_array_named(name, name, type, num, perm)

#define module_param_array_named(name, array, type, num, perm)          \
        static struct kparam_array __param_arr_##name                   \
        = { ARRAY_SIZE(array), &num, param_set_##type, param_get_##type,\
            sizeof(array[0]), array };                                  \
        module_param_call(name, param_array_set, param_array_get,       \
                          &__param_arr_##name, perm)

Take special note of the '&' before 'num' in the above initialiser, and
check the structure:

struct kparam_array
{
        unsigned int max;
        unsigned int *num;
        param_set_fn set;
        param_get_fn get;
        unsigned int elemsize;
        void *elem;
};

Therefore, module_param_array() does _NOT_ take a pointer to an integer.
Rusty - please fix.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
