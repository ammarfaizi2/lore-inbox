Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143885AbRAHOzh>; Mon, 8 Jan 2001 09:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144004AbRAHOz2>; Mon, 8 Jan 2001 09:55:28 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:47116 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S143885AbRAHOyw>; Mon, 8 Jan 2001 09:54:52 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A59D38B.B05EB8B@yahoo.com>
Date: Mon, 08 Jan 2001 09:49:47 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.0 i486)
MIME-Version: 1.0
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
CC: linux-kernel@vger.kernel.org, axel@uni-paderborn.de
Subject: Re: [PATCH] More Configure.help fixes
In-Reply-To: <20010107225730.A8883@foozle.turbogeek.org> <20010107231228.A8927@foozle.turbogeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configure.help also has help text for some 35 CONFIG_xxxx options that
have since been removed from the config.in files.  Here is a little
script to prune out those orphan entries (it is only 1/10th the size
of the resulting diff, and its the gift that keeps on giving....)

It tells you how many CONFIG options exist that don't yet have help text
as an added bonus bit of trivia. 

Paul.

--------------------8<-----cut here------8<---------------------
#!/bin/sh
# Check Documentation/Configure.help - define_bool/int entries aren't seen
# by the end user and don't need help entries. Create ed script to prune out
# orphans and execute it.			Paul Gortmaker 01/2001.

if [ ! -r Documentation/Configure.help ]; then
	echo Cant read or find Documentation/Configure.help
	exit
fi

echo -ne '\nTotal number of orphan config help entries: '
FILES=`find . -name [cC]onfig.in`

grep '^CONFIG_[0-9A-Za-z_]' Documentation/Configure.help|\
	sort|uniq>/tmp/tmp-help.$$

# Tab and space inside [  ]
cat $FILES|grep -v define_| \
	sed 's/.*[ 	]\(CONFIG_[A-Za-z0-9_]\+\)[ 	]*.*$/\1/;t;d'|\
	sort|uniq>/tmp/tmp-opt.$$

diff -u /tmp/tmp-opt.$$ /tmp/tmp-help.$$|\
	grep '^\+CONFIG_'|sed 's/^\+//'>/tmp/tmp-orph.$$

OCOUNT=`wc -l < /tmp/tmp-orph.$$`
echo $OCOUNT

echo -ne '\nTotal number of config options without any help text: '
diff -u /tmp/tmp-help.$$ /tmp/tmp-opt.$$|grep '^\+'|wc -l

if [ $OCOUNT -eq 0 ];then
	exit 0
fi

echo -ne '\nCopy originial: '
mv -vf Documentation/Configure.help Documentation/Configure.help~ 

echo "ed -s Documentation/Configure.help~<<EOF">/tmp/tmp-ed.$$
for i in `cat /tmp/tmp-orph.$$`
do
	echo "/$i/;-kz">>/tmp/tmp-ed.$$
	echo "'z,/^[A-Za-z0-9#]/-d">>/tmp/tmp-ed.$$
done
echo wq Documentation/Configure.help>>/tmp/tmp-ed.$$
echo EOF>>/tmp/tmp-ed.$$

echo -ne \\nUnleashing ed\(1\) on orphans in Configure.help...
. /tmp/tmp-ed.$$
echo -e done.\\n

# rm -f /tmp/tmp-opt.$$ /tmp/tmp-help.$$ /tmp/tmp-orph.$$ /tmp/tmp-ed.$$
--------------------8<-----cut here------8<---------------------



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
