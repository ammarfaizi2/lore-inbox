Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVAXOlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVAXOlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVAXOlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:41:39 -0500
Received: from smtp1.poczta.onet.pl ([213.180.130.31]:40096 "EHLO
	smtp1.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S261292AbVAXOlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:41:37 -0500
From: Sebastian Piechocki <sebekpi@poczta.onet.pl>
Reply-To: sebekpi@poczta.onet.pl
To: linux-kernel@vger.kernel.org
Subject: i8042 and AUX not detected with acpi=on.
Date: Mon, 24 Jan 2005 15:41:27 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200501241541.27325.sebekpi@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i'm owner of P10-824 (its the same as yours 792, difference is that 824 
is some kind of German version). I had problem with touchpad, 
tried many kernel versions with no positive result. The computer is ATI 
RS300 based with ATI IXP and Mobility Radeon 9700.
The problem lies in the i8042.c driver in kernel. It is very strange, 
because with kernel option acpi=off touchpad is detected, sorry, ps/2 
port AUX is detected and touchpad too. But if acpi=on only keyboard is 
detected by i8042 driver no AUX. I resolved this problem by debuging 
driver and change the code.
I found that driver is checking AUX existence sending loop command to 
controller. Unfortunately this ends with timeout, no response was send. 
The driver know about such problems with loop command and retries 
detecting by another command that with toshiba mouse controller fails.
The details:
In method:
  i8042_check_aux

There is:
param = 0x5a;
        if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) 
{

/*
 * External connection test - filters out AT-soldered PS/2 i8042's
 * 0x00 - no error, 0x01-0x03 - clock/data stuck, 0xff - general error
 * 0xfa - no error on some notebooks which ignore the spec
 * Because it's common for chipsets to return error on perfectly 
functioning
 * AUX ports, we test for this only when the LOOP command failed.
 */

                if (i8042_command(&param, I8042_CMD_AUX_TEST)
                        || (param && param != 0xfa && param != 0xff))
                                return -1;
        }

I have commented the line with return -1.
I know that this solution is very stupid, but works fine.
I use 2.6.11-rc1-mm1 kernel, and my touchpad is detected as ALPS.

I think this is some special situation, that need extra detection 
possibility? Am I right?
-- 
Sebastian Piechocki
sebekpi@poczta.onet.pl
