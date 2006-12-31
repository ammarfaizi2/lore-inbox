Return-Path: <linux-kernel-owner+w=401wt.eu-S1030435AbWLaSzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWLaSzk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWLaSzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 13:55:40 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:53186 "EHLO rs27.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030435AbWLaSzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 13:55:40 -0500
Message-ID: <459807A0.9080604@firmworks.com>
Date: Sun, 31 Dec 2006 08:55:28 -1000
From: Mitch Bradley <wmb@firmworks.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: "OLPC Developer's List" <devel@laptop.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <459714A6.4000406@firmworks.com> <84144f020612310524u5e2e179esd5af4a11c1c1d2f8@mail.gmail.com>
In-Reply-To: <84144f020612310524u5e2e179esd5af4a11c1c1d2f8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made all the changes Pekka suggested, except:

> +               security = strncmp(propname, "security-", 9) == 0;
>> +               len = 0;
>
> Redundant assignment, no?
>
>> +               if (!security)
>> +                       (void)callofw("getproplen", 2, 1, node, 
>> propname, &len);
>
That assignment turns out not to be redundant.  If a security variable 
is recognized, you want the length to be 0 so as not to expose the 
password.  In that case the following "getproplen" call won't be executed.

That logic was adapted from the existing file fs/proc/devtree.c .  It 
turns out that the code there has a bug: You really want to look for 
just "security-password" ; there is no need to, and good reasons not to, 
suppress the length of "security-mode" and "security-#badlogins".  (Good 
OFW implementations won't leak the password length anyway, so check is 
only needed as a workaround).

I have rewritten the code for clarity and correctness thusly:

        if (strcmp(propname, "security-password") == 0) {
            len = 0;        /* Don't leak password length */
        } else {
            callofw("getproplen", 2, 1, node, propname, &len);
        }



