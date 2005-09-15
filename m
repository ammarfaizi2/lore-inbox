Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVIOMoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVIOMoN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVIOMoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:44:13 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:22152 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S1030397AbVIOMoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:44:11 -0400
Subject: RE: kbuild & C++
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 15 Sep 2005 14:35:14 +0200
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <809C13DD6142E74ABE20C65B11A2439802094E@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild & C++
Thread-Index: AcW2AyXLgjmyGYIATJaO8ItA+xsOowD7l+lA
From: "Budde, Marco" <budde@telos.de>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

>> How can I compile this code with kbuild? The C++ support
>> (I have tested with 2.6.11) of kbuild seems to be incomplete /
>> not working.
> Since you did not send any sample code shall I assume this was not a
> serious request?

it is of course a serious request.

At the moment we are using some additional rules for kbuild.
They have worked for a previous project of our customer and I
hope they will work for this project, too.

-------------------------------------------------------------------

include $(SRC_ROOT)comps/Kbuild.includes

EXTRA_CPPFLAGS += -fno-exceptions -fno-rtti \
                  $(INCLUDE_DIRS)
EXTRA_CFLAGS += $(INCLUDE_DIRS)


%.o: %.cpp FORCE
	$(call cmd,force_checksrc)
	$(call if_changed_rule,cc_o_cpp)


quiet_cmd_cc_o_cpp = C++ $(quiet_modtag)  $@


ifndef CONFIG_MODVERSIONS
cmd_cc_o_cpp = $(CXX) $(cpp_flags) -c -o $@ $<
else
cmd_cc_o_cpp = $(CXX) $(cpp_flags) -c -o $(@D)/.tmp_$(@F) $<
endif



define rule_cc_o_cpp
        $(if $($(quiet)cmd_checksrc),echo '  $($(quiet)cmd_checksrc)';)
\
        $(cmd_checksrc)
\
        $(if $($(quiet)cmd_cc_o_cpp),echo '  $($(quiet)cmd_cc_o_cpp)';)
\
        $(cmd_cc_o_cpp);
\
        $(cmd_modversions)
\
        scripts/basic/fixdep $(depfile) $@ '$(cmd_cc_o_cpp)' >
$(@D)/.$(@F).tmp;  \
        rm -f $(depfile);
\
        mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd
endef

-------------------------------------------------------------------


