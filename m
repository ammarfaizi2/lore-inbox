Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263158AbTC1VfR>; Fri, 28 Mar 2003 16:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263159AbTC1VfR>; Fri, 28 Mar 2003 16:35:17 -0500
Received: from 011.065.dsl.concepts.nl ([213.197.11.65]:59144 "EHLO
	d594e05b.dsl.concepts.nl") by vger.kernel.org with ESMTP
	id <S263158AbTC1VfP>; Fri, 28 Mar 2003 16:35:15 -0500
Subject: some 2.5.66 issues
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048893853.1314.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Mar 2003 00:24:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

people are asking for comments on 2.5.x, so here goes. gcc-2.96, RH-7.3,
kernel 2.5.66 with module-init-tools-0.9.10.

* the smc-ultra networking module doesn't work. On any operation, it
returns "Device or Resource Busy".
* module_request() is still broken - it returns 0 but the specified
module isn't loaded

Now, something more problematic. I'm being told to use try_module_get()
instead of MOD_INC_USE_COUNT. Cool. Somehow, it returns 1. I had a look
at the code in linux/module.h and am a bit confused:

--
static inline int try_module_get(struct module *module) 
{ 
        int ret = 1; 
                                                                                 
        if (module) { 
                unsigned int cpu = get_cpu(); 
                if (likely(module_is_live(module))) 
                        local_inc(&module->ref[cpu].count); 
                else 
                        ret = 0; 
                put_cpu(); 
        } 
        return ret; 
}
--

Why does it only return 0 if the module is not alive? This sounds...
er... weird? Can someone please enlighten me?

Looking further:

--
/* Not Yet Implemented */ 
#define MODULE_AUTHOR(name) 
#define MODULE_DESCRIPTION(desc) 
#define MODULE_SUPPORTED_DEVICE(name) 
#define MODULE_PARM_DESC(var,desc)
--

No wonder modinfo doesn't show any info... Even worse, the only module
parameter thing that *does* work is MODULE_PARM...

--
/* DEPRECATED: Do not use. */ 
#define MODULE_PARM(var,type) \
struct obsolete_modparm __parm_##var \
__attribute__((section("__obsparm"))) \
{ __stringify(var), type };
--

Interesting. What's going on here?

Ronald

(please CC me any replies, I'm not subscribed)

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

