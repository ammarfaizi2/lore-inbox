Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTJ2Mjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 07:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTJ2Mjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 07:39:55 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:13051 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262048AbTJ2Mjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 07:39:53 -0500
Date: Wed, 29 Oct 2003 13:38:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Ref-count problem in kset_find_obj?
Message-ID: <20031029123820.GA1141@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pat,
looking through the sysfs code I noticed a potential problem in
kset_find_obj:

struct kobject * kset_find_obj(struct kset * kset, const char * name)
{
        struct list_head * entry;
        struct kobject * ret = NULL;

        down_read(&kset->subsys->rwsem);
        list_for_each(entry,&kset->list) {
                struct kobject * k = to_kobj(entry);
                if (!strcmp(kobject_name(k),name)) {
			ret = k;
			break;
                }
        }
        up_read(&kset->subsys->rwsem);
        return ret;
}

The reference count of the kobject to be returned is not
increased before the semaphore is released. A kobject_del/unlink
could remove the object before the called of kset_find_obj is
able to increase the reference count. This makes kset_find_obj
more or less unusable, doesn't it?

blue skies,
  Martin.

