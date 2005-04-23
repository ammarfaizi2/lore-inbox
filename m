Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVDWJw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVDWJw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 05:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDWJw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 05:52:57 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16084 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261526AbVDWJwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 05:52:53 -0400
Date: Sat, 23 Apr 2005 11:52:48 +0200 (MEST)
Message-Id: <200504230952.j3N9qm6W012596@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: gcc-4.0.0 final miscompiles net/ipv4/devinet.c:devinet_sysctl_register()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-4.0.0 miscompiles a pointer subtraction operation in
net/ipv4/devinet.c, resulting in oopses from /sbin/sysctl.

Below is a copy of the test case I just sent to gcc bugzilla.

/Mikael

/* gcc4pointersubtractionbug.c
 * Written by Mikael Pettersson, mikpe@csd.uu.se, 2005-04-23.
 *
 * This program illustrates a code optimisation bug in
 * gcc-4.0.0 (final) and gcc-4.0.0-20050417, where a pointer
 * subtraction operation is compiled as a pointer addition.
 * Observed at -O2. gcc was configured for i686-pc-linux-gnu.
 *
 * This bug broke net/ipv4/devinet.c:devinet_sysctl_register()
 * in the linux-2.6.12-rc2 Linux kernel, causing /sbin/sysctl
 * to trigger kernel oopses.
 *
 * gcc-4.0.0-20050416 and earlier prereleases do not have this bug.
 */
#include <stdio.h>
#include <string.h>

#define NRVARS	5

struct ipv4_devconf {
    int var[NRVARS];
};
struct ipv4_devconf ipv4_devconf[2];

struct ctl_table {
    void *data;
};

struct devinet_sysctl_table {
    struct ctl_table devinet_vars[NRVARS];
};

void devinet_sysctl_relocate(struct devinet_sysctl_table *t,
			     struct ipv4_devconf *p)
{
    int i;

    for (i = 0; i < NRVARS; i++)
	/* Initially data points to a field in ipv4_devconf[0].
	   This code relocates it to the corresponding field in *p.
	   At -O2, gcc-4.0.0-20050417 and gcc-4.0.0 (final)
	   miscompile this pointer subtraction as a pointer addition. */
	t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf[0];
}

struct devinet_sysctl_table devinet_sysctl;

int main(void)
{
    struct devinet_sysctl_table t;
    int i;

    for(i = 0; i < NRVARS; i++)
	devinet_sysctl.devinet_vars[i].data = &ipv4_devconf[0].var[i];

    memcpy(&t, &devinet_sysctl, sizeof t);
    devinet_sysctl_relocate(&t, &ipv4_devconf[1]);

    for(i = 0; i < NRVARS; i++)
	if (t.devinet_vars[i].data != &ipv4_devconf[1].var[i]) {
	    fprintf(stderr, "t.devinet_vars[%u].data == %p, should be %p\n",
		    i,
		    t.devinet_vars[i].data,
		    &ipv4_devconf[1].var[i]);
	    return 1;
	}

    printf("all ok\n");
    return 0;
}
