Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVDFNK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVDFNK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVDFNK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:10:29 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:19345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262197AbVDFNKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iFOX9IPASe40Q13BkwBWQO0w4Ls7MIDsnfSLm77+Q9qV5KuNdBw6B7KgAp+pNbtxuHIAwDqN61+AUJqLwTpdaLhm5nOHrmDI2guaNOu7Y/O1BGI3i1GYIelpQwbykOATUsJ3HffD6JvKVpiydEDQ5EBjAX+AMdYozjxDY/fF99o=
Message-ID: <aec7e5c305040606104c86712c@mail.gmail.com>
Date: Wed, 6 Apr 2005 15:10:15 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Malcolm Rowe <malcolm-linux@farside.org.uk>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
In-Reply-To: <courier.4253BAD7.000018D2@mail.farside.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405225747.15125.8087.59570@clementine.local>
	 <courier.4253BAD7.000018D2@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 12:32 PM, Malcolm Rowe <malcolm-linux@farside.org.uk> wrote:
> Magnus Damm writes:
> > Here comes version 2 of the disable built-in patch.
> 
> > +void __init disable_initcall(void *fn)
> > +{
> > +     initcall_t *call;
> > +
> > +     for (call = __initcall_start; call < __initcall_end; call++) {
> > +
> > +             if (*call == fn)
> > +                     *call = NULL;
> > +     }
> > +}
> 
> Regardless of anything else, won't this break booting with initcall_debug on
> PPC64/IA64 machines? (see the definition of print_fn_descriptor_symbol() in
> kallsyms.h)

Correct, thanks for pointing that out. The code below is probably better:

 static void __init do_initcalls(void)
 {
        initcall_t *call;
@@ -547,6 +558,9 @@ static void __init do_initcalls(void)
        for (call = __initcall_start; call < __initcall_end; call++) {
                char *msg;

+               if (!*call)
+                       continue;
+
                if (initcall_debug) {
                        printk(KERN_DEBUG "Calling initcall 0x%p", *call);
                        print_fn_descriptor_symbol(": %s()", (unsigned
long) *call);

And I guess the idea of replacing the initcall pointer with NULL will
work both with and without function descriptors, right? So we should
be safe on IA64 and PPC64.

Regards,

/ magnus
