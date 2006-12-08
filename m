Return-Path: <linux-kernel-owner+w=401wt.eu-S1760711AbWLHNZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760711AbWLHNZ2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760712AbWLHNZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:25:28 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:39313 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760711AbWLHNZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:25:27 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 08 Dec 2006 14:24:45 +0100
MIME-Version: 1.0
Subject: 2.6.19: slight performance optimization for lib/string.c's strstrip()
Message-ID: <457975AE.31261.15F652B2@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.10.0+V=4.10+U=2.07.149+R=02 October 2006+T=193714@20061208.132500Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my apologies for disobeying all the rules for submitting patches, but I'll suggest 
a performance optimization for strstrip() in lib/string.c:

Original routine:
char *strstrip(char *s)
{
       size_t size;
       char *end;

       size = strlen(s);

       if (!size)
               return s;

       end = s + size - 1;
       while (end >= s && isspace(*end))
               end--;
       *(end + 1) = '\0';

       while (*s && isspace(*s))
               s++;

       return s;
}
EXPORT_SYMBOL(strstrip);


Suggested replacement:

char *strstrip(char *s)
{
       size_t size;
       char *end;

       while (*s && isspace(*s))
               s++;
       if (!*s)
               return s;
       size = strlen(s);

       end = s + size - 1;
       while (end > s && isspace(*end))
               end--;
       *(end + 1) = '\0';

       return s;
}
EXPORT_SYMBOL(strstrip);

Comments: There's no need to scan the initial banks at the start of the string 
twice (using strlen(), and then looking for initial blanks), and we know that the 
first character of the string cannot be a blank when we are removing trailing 
blanks after having removed leading blanks. Also we do not need to call strlen() 
to detect an empty string.

Regards,
Ulrich

