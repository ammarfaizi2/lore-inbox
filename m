Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTILJ7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTILJ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:59:17 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:63698 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261360AbTILJ7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:59:12 -0400
To: <linux-kernel@vger.kernel.org>
Cc: andrew.grover@intel.com
Subject: 2.4.23-pre2 BUG() - ACPI + sysrq power_off
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Sep 2003 11:47:05 +0200
Message-ID: <m33cf2z6cm.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.4.23-pre2 (and with some older kernels as well) I get BUG()
after pressing sysrq+Off (power off) with ACPI.

kernel/pm.c (line 159):

int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data)
{
        int status = 0;
        int prev_state, next_state;

        if (in_interrupt())
                BUG();    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        switch (rqst) {
        case PM_SUSPEND:
        case PM_RESUME:
                prev_state = dev->state;
                next_state = (unsigned long) data;
                if (prev_state != next_state) {
                        if (dev->callback)
                                status = (*dev->callback)(dev, rqst, data);
                        if (!status) {
                                dev->state = next_state;
                                dev->prev_state = prev_state;
                        }
                }
                else {
                        dev->prev_state = prev_state;
                }
                break;
        default:
                if (dev->callback)
                        status = (*dev->callback)(dev, rqst, data);
                break;
        }
        return status;
}

It seems sysrq-O routine (acpi_sysrq_power_off() -> acpi_power_off() ->
acpi_suspend(ACPI_STATE_S5)) calls pm_send() from keyboard interrupt,
which isn't exactly what pm_send() like.

Details available on request, if needed.
Not checked with 2.6test yet.


Another thing: on my notebook, /sbin/poweroff doesn't power the machine
off with 2.4 (it worked with older 2.4 kernels). echo 5 > /proc/acpi/sleep
does the job. Any ideas?
-- 
Krzysztof Halasa, B*FH
