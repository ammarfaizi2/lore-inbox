Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSJIMOp>; Wed, 9 Oct 2002 08:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSJIMOo>; Wed, 9 Oct 2002 08:14:44 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:25828 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261585AbSJIMOn>;
	Wed, 9 Oct 2002 08:14:43 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Brian F. G. Bidulock" <bidulock@openss7.org>
Date: Wed, 9 Oct 2002 14:20:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: export of sys_call_table
Cc: linux-kernel@vger.kernel.org, LiS <linux-streams@gsyc.escet.urjc.es>,
       davem@redhat.com
X-mailer: Pegasus Mail v3.50
Message-ID: <41C1FEE0A55@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Oct 02 at 18:21, Brian F. G. Bidulock wrote:
> --- kernel/sys.c.orig   2002-08-02 19:39:46.000000000 -0500
> +++ kernel/sys.c    2002-10-08 16:46:55.000000000 -0500
...

I believe that you should check that nobody else has registered its
own streams module. You can also allow for multiple streams modules
in parallel (and fall through when module returns on -ENOIOCTLCMD or -ENOTTY),
but I believe that usually only one module will be registered.

And I believe that export symbols should NOT be _GPL_ONLY: before
(non-GPL) export of syscall_table was available, non-GPL modules were
able to hook syscalls, and when _GPL_ONLY was introduced into kernel
it was promised that we'll never make currently provided functionality
GPL-only (as far as I remember).
                                                    Best regards,
                                                        Petr Vandrovec
                                                        
int register_streams_calls(...)
> +void register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
> +               int (*getpmsg) (int, void *, void *, int, int))
> +{

int err;
if (!putpmsg || !getpmsg) return -EINVAL;

> +   down_write(&streams_call_sem);

err = -EBUSY;
if (!do_putpmsg) {
  err = 0;

> +   do_putpmsg = putpmsg;
> +   do_getpmsg = getpmsg;

}

> +   up_write(&streams_call_sem);

return err;

> +}
> +
> +void unregister_streams_calls(void)
> +{

   down_write(&streams_call_sem);
   do_putpmsg = NULL;
   do_getpmsg = NULL;
   up_write(&streams_call_sem);
}
    
